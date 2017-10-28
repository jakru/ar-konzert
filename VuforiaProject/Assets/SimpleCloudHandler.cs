using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;
using UnityEngine.Video;
using Vuforia;
using System.Collections;
using System.IO;

public class SimpleCloudHandler : MonoBehaviour, ICloudRecoEventHandler
{
    private CloudRecoBehaviour mCloudRecoBehaviour;
    private ObjectTracker mObjectTracker;
    private bool mIsScanning = false;
    private bool mFoundResult = false;
    private int mSec = 0;
    private AudioSource mAudioSource;
    private VuforiaObject mVuforiaObject;
    private GameObject mModel3d;
    
    private VideoPlayer videoPlayer;
    public RawImage image;
    GameObject rawImage;

    private GameObject cloudRecoTarget;
    private Button playBtn;
    private GameObject playBtnObj;
    private Button pauseBtn;
    private GameObject pauseBtnObj;
    private GameObject linkBtnObj;
    private Button linkBtn;
    private GUIStyle style;

    public ImageTargetBehaviour ImageTargetTemplate;
    public ScanLine scanLine;
    public string log;

    // Use this for initialization
    void Start()
    {
        log = "Start= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        // register this event handler at the cloud reco behaviour
        mCloudRecoBehaviour = GetComponent<CloudRecoBehaviour>();

        if (mCloudRecoBehaviour)
        {
            mCloudRecoBehaviour.RegisterEventHandler(this);
        }

        InitializeGameObjects();
    }

    // Update is called once per frame
    void Update() {
        mSec++;
    }

    void OnGUI()
    {
        // Anzeige des Typs der in den Metadaten steht
        //if (mVuforiaObject != null)
        //    GUI.Box(new Rect(500, 100, 1000, 50), mVuforiaObject.type + ": " + mVuforiaObject.url);

        if (style == null)
        {
            style = new GUIStyle(GUI.skin.box);
            style.alignment = TextAnchor.MiddleCenter;
            style.fontSize = 40;
        }

        // Hinweisanzeige beim Start der App
        if (mSec < 500 && !mFoundResult)
            GUI.Box(new Rect(600, 500, 800, 200), 
                "Bitte richten Sie die Kamera\n auf ein Plakat des Konzerthauses Berlin!", style);
        // Hinweis bei fehlgeschlagener Initialisierung
        else if (!mIsScanning)
            GUI.Box(new Rect(600, 500, 800, 200), 
                "Die Initialisierung ist fehlgeschlagen :(\n Bitte starten Sie die App neu!", style);
    }

    void OnApplicationQuit()
    {
        log += ";Application Quit";
        File.WriteAllText(Application.persistentDataPath + "/log.txt", log);
    }
    void OnApplicationFocus()
    {
        log += ";Application Focus";
        File.WriteAllText(Application.persistentDataPath + "/log.txt", log);
    }

    public void OnInitialized()
    {
        log += ";Initialisiert= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        Debug.Log("Cloud Reco initialized");
        // get a reference to the Object Tracker, remember it
        mObjectTracker = TrackerManager.Instance.GetTracker<ObjectTracker>();
    }
    public void OnInitError(TargetFinder.InitState initError)
    {
        Debug.Log("Cloud Reco init error " + initError.ToString());
    }
    public void OnUpdateError(TargetFinder.UpdateState updateError)
    {
        Debug.Log("Cloud Reco update error " + updateError.ToString());
    }

    public void OnStateChanged(bool scanning)
    {
        mIsScanning = scanning;
        if (scanning)
        {
            // clear all known trackables
            mObjectTracker.TargetFinder.ClearTrackables(false);            
        }

        ShowScanLine(scanning);
    }

    // Here we handle a cloud target recognition event
    public void OnNewSearchResult(TargetFinder.TargetSearchResult targetSearchResult)
    {
        log += ";New Search Result - " + targetSearchResult.TargetName + "=" + System.DateTime.Now.ToString("hh:mm:ss.fff");
        ResetResults();

        //Umwandeln der Metadaten in Objekt
        mVuforiaObject = new VuforiaObject();
        mVuforiaObject = JsonUtility.FromJson<VuforiaObject>(targetSearchResult.MetaData);

        log += ";Umwandlung der Metadaten fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        switch (mVuforiaObject.type)
        {
            case "ExternalLink":
				// Anzeige des Link-Buttons
                log += ";Externer Link erkannt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                linkBtn.onClick.AddListener(() => OpenLink(mVuforiaObject.url));
                SetButtonFormat(linkBtnObj, linkBtn);
                log += ";Externer Link fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                break;
            case "Video":
				// Laden des Videos und Anzeige des Play-Buttons
                log += ";Video erkannt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                StartCoroutine(LoadVideo((mVuforiaObject.url)));
                log += ";Video fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                break;
            case "Audio":
				// Laden der Audio-Datei und Anzeige des Play-Buttons
                log += ";Audio erkannt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                StartCoroutine(LoadAudio(mVuforiaObject.url));                
                log += ";Audio fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                break;
            case "3D-Modell":
				// Laden des 3D-Modells und Anzeige des Modells
                log += ";3D-Modell erkannt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                StartCoroutine(InstantiateObject(mVuforiaObject.url));
                log += ";3D-Modell fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
                break;
            default:
                break;
        }

        if (mVuforiaObject != null && ImageTargetTemplate)
        {
            // enable the new result with the same ImageTargetBehaviour:
            ImageTargetBehaviour imageTargetBehaviour =
                (ImageTargetBehaviour)mObjectTracker.TargetFinder
                    .EnableTracking(targetSearchResult, ImageTargetTemplate.gameObject);
        }
        log += ";Behaviour fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    IEnumerator LoadAudio(string url)
    {
		// Herunterladen der Audio-Datei
        log += ";Audio wird geladen= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        WWW www = new WWW(url);
        mAudioSource.clip = www.GetAudioClip();

		// Warten bis der Ladeprozess abgeschlossen ist
        while (!www.isDone)
        {
            Debug.Log("Preparing Audio");
            yield return null;
        }
        log += ";Audio laden fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");

		// Anzeige des Play-Buttons
        playBtn.onClick.AddListener(() => PlayAudio());
        pauseBtn.onClick.AddListener(PauseAudio);
        SetButtonFormat(playBtnObj, playBtn);
    }

    IEnumerator<AsyncOperation> InstantiateObject(string uri)
    {
		// Laden des Asset-Bundles über Web-Request
        log += ";3D-Modell wird geladen= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        UnityWebRequest request = UnityWebRequest.GetAssetBundle(uri, 0);
        yield return request.Send();
        AssetBundle bundle = DownloadHandlerAssetBundle.GetContent(request);
        // Speichern des ersten Objekts
		UnityEngine.Object[] models = bundle.LoadAllAssets();
		mModel3d = Instantiate((GameObject)models[0]);
        // Transformieren des Models mit entsprechenden Werten
		mModel3d.transform.parent = cloudRecoTarget.transform;
        mModel3d.transform.Rotate(90, 0, 0);
        mModel3d.transform.position = new Vector3(mVuforiaObject.xCoord, 0, mVuforiaObject.yCoord);
        mModel3d.transform.localScale = new Vector3(mVuforiaObject.sizeOfContent[0], mVuforiaObject.sizeOfContent[1], mVuforiaObject.sizeOfContent[2]);
        log += ";3D-Modell fertig geladen= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    IEnumerator LoadVideo(string url)
    {
        log += ";Video wird geladen= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        // Hinzufügen eines Videoplayers und initialisieren
		videoPlayer = gameObject.AddComponent<VideoPlayer>();
        videoPlayer.playOnAwake = false;
        videoPlayer.isLooping = true;
        videoPlayer.url = url;
        videoPlayer.Play();

        // Warten bis das Video geladen ist
        while (videoPlayer.texture == null)
        {
            Debug.Log("Preparing Video");
            log += ";Preparing Video= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
            yield return null;
        }
        videoPlayer.errorReceived += (source, message) => { log += "Video player error: " + message; };
        log += ";Video vorbereiten fertig= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        // Anzeige der Videoplay-Texture auf dem Image
		image.texture = videoPlayer.texture;
        videoPlayer.Stop();
        log += ";Video fertig geladen= " + System.DateTime.Now.ToString("hh:mm:ss.fff");

		// Transformieren des Bilds und des Play-Buttons
        rawImage.transform.position = new Vector3(mVuforiaObject.xCoord, 1, mVuforiaObject.yCoord);
        image.rectTransform.sizeDelta = new Vector2(mVuforiaObject.sizeOfContent[0] * 2, mVuforiaObject.sizeOfContent[1] * 2);
        rawImage.SetActive(true);

        SetButtonFormat(playBtnObj, playBtn);

        playBtn.onClick.AddListener(() => PlayVideo());
        pauseBtn.onClick.AddListener(PauseVideo);
    }

    #region PRIVATE_METHODS
    private void InitializeGameObjects()
    {
        cloudRecoTarget = GameObject.Find("CloudRecoTarget");
        rawImage = GameObject.Find("RawImage");
        rawImage.SetActive(false);
        mAudioSource = GetComponent<AudioSource>();

        playBtnObj = GameObject.Find("PlayButton");
        playBtnObj.SetActive(false);
        playBtn = playBtnObj.GetComponent<Button>();

        pauseBtnObj = GameObject.Find("PauseButton");
        pauseBtnObj.SetActive(false);
        pauseBtn = pauseBtnObj.GetComponent<Button>();

        linkBtnObj = GameObject.Find("LinkButton");
        linkBtnObj.SetActive(false);
        linkBtn = linkBtnObj.GetComponent<Button>();
    }

    private void ShowScanLine(bool show)
    {
        // Toggle scanline rendering
        if (scanLine != null)
        {
            Renderer scanLineRenderer = scanLine.GetComponent<Renderer>();
            if (show)
            {
                // Enable scan line rendering
                if (!scanLineRenderer.enabled)
                    scanLineRenderer.enabled = true;

                scanLine.ResetAnimation();
            }
            else
            {
                // Disable scanline rendering
                if (scanLineRenderer.enabled)
                    scanLineRenderer.enabled = false;
            }
        }
    }

    private void ResetResults ()
    {
        mFoundResult = true;
        playBtn.onClick.RemoveAllListeners();
        playBtnObj.SetActive(false);
        pauseBtnObj.SetActive(false);
        linkBtnObj.SetActive(false);
        ShowScanLine(false);
        rawImage.SetActive(false);
        mAudioSource.clip = null;

        if (videoPlayer != null)
            DestroyImmediate(videoPlayer, true);
        
        if (mModel3d != null)
            DestroyImmediate(mModel3d, true);
    }
    
    private void SetButtonFormat(GameObject obj, Button btn)
    {
        obj.transform.position = new Vector3(mVuforiaObject.xCoord, 1, mVuforiaObject.yCoord);
        btn.image.rectTransform.sizeDelta = new Vector2(mVuforiaObject.sizeOfContent[0], mVuforiaObject.sizeOfContent[1]);

        obj.SetActive(true);
    }

    private void PlayVideo()
    {
		// Video abspielen und Pause-Button anzeigen
        log += ";Play Button wurde geklickt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        videoPlayer.Play();
        SetButtonFormat(pauseBtnObj, pauseBtn);
        playBtnObj.SetActive(false);
        log += ";Video wird abgespielt und Pause-Button angezeigt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    private void PauseVideo()
    {
		// Video anhalten und Play-Button anzeigen
        log += ";Pause Button wurde geklickt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        videoPlayer.Pause();

        playBtnObj.SetActive(true);
        pauseBtnObj.SetActive(false);
        log += ";Video wurde angehalten und Play-Button wird angezeigt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    private void PlayAudio()
    {
		// Wenn die Audioquelle geladen ist und noch nicht abgespielt wird
        log += ";Play Button wurde geklickt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        if (mAudioSource && mAudioSource.clip.loadState == AudioDataLoadState.Loaded 
            && !mAudioSource.isPlaying)
				// Abspielen der Audioquellee
                mAudioSource.Play();
		// Anzeigen des Pause-Buttons und Deaktivieren des Play-Buttons
        SetButtonFormat(pauseBtnObj, pauseBtn);
        playBtnObj.SetActive(false);
        log += ";Audio spielt und Pause button wird angezeigt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    private void PauseAudio()
    {
        log += ";Pause Button wurde geklickt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        if (mAudioSource.isPlaying)
            mAudioSource.Pause();
        playBtnObj.SetActive(true);
        pauseBtnObj.SetActive(false);
        log += ";Audio wurde angehalten und Play-Button angezeigt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }

    public void OpenLink(string url)
    {
		// Öffnen der angegebenen URL im Browser
        log += ";Link Button wurde geklickt= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
        Application.OpenURL(url);
        log += ";URL wurde geöffnet= " + System.DateTime.Now.ToString("hh:mm:ss.fff");
    }
    #endregion //PRIVATE_METHODS
}