package org.opencms.scheduler.jobs;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.opencms.db.CmsResourceState;
import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsProperty;
import org.opencms.file.CmsPropertyDefinition;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.types.CmsResourceTypeImage;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.report.CmsLogReport;
import org.opencms.report.I_CmsReport;
import org.opencms.scheduler.I_CmsScheduledJob;

import com.qualcomm.vuforia.CloudRecognition.samples.PostNewTarget;

/**
 * Scheduled job for vuforia
 */
public class CmsPostNewTargetJob implements I_CmsScheduledJob {

	public String launch(CmsObject cms, Map<String, String> parameters) throws Exception {

		I_CmsReport report = new CmsLogReport(cms.getRequestContext().getLocale(), CmsPostNewTargetJob.class);

		List<CmsResource> resources = Collections.emptyList();
		List<CmsResource> contentResources = Collections.emptyList();

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		System.out.println("Startzeit:" + sdf.format(cal.getTime()));
		
		// now iterate through all marker folder
		String folder = "/sites/default/.galleries/Konzerthaus-Daten/";
		Iterator<CmsResource> j = cms.getSubFolders(folder).iterator();
		CmsResource r = null;
		while (j.hasNext()) {
			r = (CmsResource)j.next();
			folder = cms.getSitePath(r);
			
			try {
				// get all image resources from testfolder
				resources = cms.readResources(folder, CmsResourceFilter.IGNORE_EXPIRATION.addRequireType(OpenCms
						.getResourceManager().getResourceType(CmsResourceTypeImage.getStaticTypeName()).getTypeId()));

				// get all content elements
				contentResources = cms.readResources(folder,
						CmsResourceFilter.DEFAULT_FILES.addExcludeType(new CmsResourceTypeImage().getTypeId()));
			} catch (CmsException e) {
				report.println(e);
			}

			// now iterate through all image resources
			for (int i = 0; i < resources.size(); i++) {

				try {
					CmsResource res = resources.get(i);

					// content element from marker
					CmsResource contRes = contentResources.get(0);
					CmsFile contFile = cms.readFile(contRes);

					// get the type from the content
					CmsProperty contentType = cms.readPropertyObject(contRes,
							CmsPropertyDefinition.PROPERTY_DEFAULT_FILE, false); 

					// get the Coordinaten
					CmsProperty xCoord = cms.readPropertyObject(contRes, CmsPropertyDefinition.PROPERTY_XCOORD, false);
					CmsProperty yCoord = cms.readPropertyObject(contRes, CmsPropertyDefinition.PROPERTY_YCOORD, false);

					// get the size from the content
					CmsProperty sizeOfContent = cms.readPropertyObject(contRes, CmsPropertyDefinition.PROPERTY_SIZE,
							false);

					// check if the marker is publish/unchange
					CmsResourceState markerState = res.getState();
					if (markerState.isUnchanged()) {

						// read the file content
						CmsFile file = cms.readFile(res);
						String filePath = file.getRootPath();
						System.out.println(filePath);

						// get the title from the image
						CmsProperty name = cms.readPropertyObject(res, CmsPropertyDefinition.PROPERTY_TITLE, false);
						String imageName = name.getValue();

						// get the width from the image for vuforia upload
						CmsProperty width = cms.readPropertyObject(res, CmsPropertyDefinition.PROPERTY_IMAGE_SIZE,
								false);

						// start vuforia upload
						PostNewTarget p = new PostNewTarget(filePath, imageName, contFile.getRootPath(),
								contentType.getValue(), xCoord.getValue(), yCoord.getValue(), sizeOfContent.getValue(),
								width.getValue());
						p.postTargetThenGetStatus();
					}
				} catch (CmsException e) {
					report.println(e);
				}
			}
		}
		return Messages.get().getBundle().key("Finish");
	}
}