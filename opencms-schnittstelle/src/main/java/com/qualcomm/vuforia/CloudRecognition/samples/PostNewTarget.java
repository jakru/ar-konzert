package com.qualcomm.vuforia.CloudRecognition.samples;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.opencms.file.CmsResource;
import org.opencms.main.CmsException;

import com.qualcomm.vuforia.CloudRecognition.utils.SignatureBuilder;

// customized class for the create and update new Target mechanism for Vuforia
// See the Vuforia Web Services Developer API Specification - https://developer.vuforia.com/resources/dev-guide/adding-target-cloud-database-api 

public class PostNewTarget {

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

	// Server Keys
	private String accessKey = "...";
	private String secretKey = "...";

	private String url = "https://vws.vuforia.com";
	private String targetName = "Plakat1"; // default value
	private String imageLocation = "http://ar-konzert.f4.htw-berlin.de:8080/opencms/export";
	List<CmsResource> imagefiles;
	String uniqueTargetId;
	String imagePath;
	String contentPath;
	String contentType = "Binär"; // default value
	String xCoord = "0"; // default value
	String yCoord = "0"; // default value
	String sizeOfContent = "[20,20]"; // default value
	String markerWidth = "100"; // default value

	public PostNewTarget(String filePath, String fileName, String contentRes, String contentDes, String xCoord,
			String yCoord, String sizeOfContent, String markerWidth) throws CmsException {

		this.imagePath = filePath;
		this.targetName = fileName;
		this.contentPath = contentRes;

		if (contentDes != null) {
			this.contentType = contentDes;
		}

		if (xCoord != null) {
			this.xCoord = xCoord;
		}

		if (yCoord != null) {
			this.yCoord = yCoord;
		}

		if (sizeOfContent != null) {
			this.sizeOfContent = sizeOfContent;
		}

		if (markerWidth != null) {
			this.markerWidth = markerWidth;
		}
	}

	private String postTarget() throws Exception {
		HttpPost postRequest = new HttpPost();
		HttpClient client = new DefaultHttpClient();
		postRequest.setURI(new URI(url + "/targets"));
		JSONObject requestBody = new JSONObject();

		setRequestBody(requestBody);

		postRequest.setEntity(new StringEntity(requestBody.toString()));
		setHeaders(postRequest); // Must be done after setting the body

		// check requests
		System.out.println("PostRequest: " + postRequest.toString());

		HttpResponse response = client.execute(postRequest);
		String responseBody = EntityUtils.toString(response.getEntity());
		System.out.println("ResponseBody: " + responseBody);

		JSONObject jobj = new JSONObject(responseBody);

		uniqueTargetId = jobj.has("target_id") ? jobj.getString("target_id") : "";
		System.out.println("\nCreated target with id: " + uniqueTargetId);

		return responseBody;
	}

	private void setRequestBody(JSONObject requestBody) throws IOException, JSONException, Exception {
		URL url = new URL(imageLocation + imagePath);
		byte[] image = IOUtils.toByteArray(url);

		// create the requestBody
		requestBody.put("name", targetName); // Mandatory
		requestBody.put("width", Double.parseDouble(markerWidth)); // Mandatory
		requestBody.put("image", Base64.encodeBase64String(image));
		requestBody.put("active_flag", 1); // Optional
		String metadata = "{\r\n\"sizeOfContent\": " + sizeOfContent + ",\r\n" + "\n\"xCoord\": \"" + xCoord + "\",\r\n"
				+ "\"yCoord\": \"" + yCoord + "\",\r\n" + "\"type\": \"" + contentType + "\",\r\n" + "\"url\": \""
				+ new URL(imageLocation + contentPath).toString().replace("/export/sites/default", "") + "\"\n}";
		requestBody.put("application_metadata", Base64.encodeBase64String(metadata.getBytes())); // Optional
	}

	private void setHeaders(HttpUriRequest request) {
		SignatureBuilder sb = new SignatureBuilder();

		// set the Header Information
		request.setHeader(new BasicHeader("Date", DateUtils.formatDate(new Date()).replaceFirst("[+]00:00$", "")));
		request.setHeader(new BasicHeader("Content-Type", "application/json"));
		request.setHeader("Authorization", "VWS " + accessKey + ":" + sb.tmsSignature(request, secretKey));
	}

	/**
	 * Posts a new target to the Cloud database and get the status
	 * 
	 * @throws Exception
	 */
	public void postTargetThenGetStatus() throws Exception {
		String resultCode = "";
		try {
			resultCode = postTarget();
			if (resultCode.contains("TargetNameExist")) {
				getAllTargets();
			}
		} catch (URISyntaxException | IOException | JSONException | CmsException e) {
			e.printStackTrace();
			return;
		}
	}

	public void updateTarget(String targetId) throws Exception {
		HttpPut putRequest = new HttpPut();
		HttpClient client = new DefaultHttpClient();
		putRequest.setURI(new URI(url + "/targets/" + targetId));
		JSONObject requestBody = new JSONObject();

		setRequestBody(requestBody);
		putRequest.setEntity(new StringEntity(requestBody.toString()));
		setHeaders(putRequest); // Must be done after setting the body

		HttpResponse response = client.execute(putRequest);
		System.out.println("Update done" + EntityUtils.toString(response.getEntity()) + "Update Zeit:"
				+ sdf.format(cal.getTime()));
	}

	private JSONObject getJSONObject(HttpGet getRequest, HttpClient client)
			throws IOException, ClientProtocolException {
		SignatureBuilder sb = new SignatureBuilder();
		getRequest.setHeader(new BasicHeader("Date", DateUtils.formatDate(new Date()).replaceFirst("[+]00:00$", "")));
		getRequest.setHeader("Authorization", "VWS " + accessKey + ":" + sb.tmsSignature(getRequest, secretKey));

		HttpResponse response = client.execute(getRequest);
		String responseBody = EntityUtils.toString(response.getEntity());
		JSONObject jobk = new JSONObject(responseBody);
		return jobk;
	}

	// get all target ids
	public void getAllTargets() throws URISyntaxException, ClientProtocolException, IOException {
		HttpGet getRequest = new HttpGet();
		HttpClient client = new DefaultHttpClient();
		getRequest.setURI(new URI(url + "/targets"));

		JSONObject jobk = getJSONObject(getRequest, client);

		JSONArray targetIds = jobk.getJSONArray("results");

		// get sepcific target id and target from vuforia
		for (int i = 0; i < targetIds.length(); i++) {
			try {
				getTarget(targetIds.getString(i));
			} catch (JSONException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void getTarget(String targetId) throws Exception {
		HttpGet getRequest = new HttpGet();
		HttpClient client = new DefaultHttpClient();
		getRequest.setURI(new URI(url + "/targets/" + targetId));

		JSONObject jobk = getJSONObject(getRequest, client);

		String vuforiaTargetName = jobk.getJSONObject("target_record").getString("name");
		if (vuforiaTargetName.equals(targetName)) {
			updateTarget(targetId);
		}
	}
}