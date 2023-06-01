using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using SimpleJSON;



public class LongPolling : MonoBehaviour
{

    public string serverURL = "https://842f-158-37-230-38.eu.ngrok.io/get_latest_values";
    public string userId = "E8QTdsFDlSU8vrwDoDkK47mETOZ2";
    public string exhibitionId = "8oUTErigJ1MCkt5wYhBT";
    public float pollingInterval = 5f; // Interval in seconds between requests
    public GameObject targetObject;
    private Vector3 initialPosition;
    private Quaternion initialRotation;
    private Vector3 initialLossyScale;
    
    private bool previousResetValue = false;

    // Start is called before the first frame update
    void Start()
    {
        initialPosition = transform.position;
        initialRotation = transform.rotation;
        initialLossyScale = transform.lossyScale;
        StartCoroutine(PollForChanges());
    }

    private IEnumerator PollForChanges()
    {
        while (true)
        {
            string url = $"{serverURL}?user_id={userId}&exhibition_id={exhibitionId}";
            UnityWebRequest request = UnityWebRequest.Get(url);
            yield return request.SendWebRequest();

            if (request.result == UnityWebRequest.Result.Success)
            {
                string jsonResponse = request.downloadHandler.text;
                UpdateValues(jsonResponse);
            }
            else
            {
                Debug.LogError($"Error fetching data: {request.error}");
            }

            yield return new WaitForSeconds(pollingInterval);
        }
    }

     private void UpdateValues(string jsonResponse)
    {
        // Parse the JSON response
        var json = JSON.Parse(jsonResponse);

        // Update your Unity app with the latest values here
        bool active = json["active"].AsBool;
        bool reset = json["reset"].AsBool;
        targetObject.SetActive(active);
        Debug.Log($"Current active value: {active}");
        if (previousResetValue != reset)
            {
                targetObject.transform.position = initialPosition;
                targetObject.transform.rotation = initialRotation;

                // Reset the local scale based on the initial global scale (lossyScale)
                if (targetObject.transform.parent != null)
                {
                    targetObject.transform.localScale = Vector3.Scale(initialLossyScale, InverseVector3(targetObject.transform.parent.lossyScale));
                }
                else
                {
                    targetObject.transform.localScale = initialLossyScale;
                }
            }
            previousResetValue = reset;
        // ...

    }
    private Vector3 InverseVector3(Vector3 vec)
    {
        return new Vector3(1 / vec.x, 1 / vec.y, 1 / vec.z);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
