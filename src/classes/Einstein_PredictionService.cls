public class Einstein_PredictionService {

    // Base URL for the PredictionService
    private static String BASE_URL = 'https://api.einstein.ai/v2';

    private String API_USAGE = BASE_URL + '/apiusage';
    private static String OAUTH2 = BASE_URL + '/oauth2/token';

    private boolean isExecuting = false;
    private String bearerToken = '';
    public Integer httpStatusCode = 0;
    public String httpErrorMessage = '';
    private Types typeEnum;
    private String typeString;
    public String baseUrl;

    public enum Types {
        IMAGE,
        IMAGE_MULTI_LABEL,
        IMAGE_DETECTION,
        SENTIMENT,
        INTENT
    }

    /**
    * <p>Create a new object of type Einstein_PredictionService.</p>
    *
    * <p>The Einstein_PredictionService is the foundation for communicating with the Salesforce Einstein Platform API.
    *
    * @param typeEnum
    * An Enum of type Einstein_PredictionService.Types which defines the type of prediction (image, image-multi-model, sentiment or intent).
    */
    public Einstein_PredictionService(Einstein_PredictionService.Types typeEnum) {
        this.bearerToken = getAccessToken();
        this.typeEnum = typeEnum;
        this.baseUrl = resolveBaseUrl();
        this.typeString = resolveType();
    }

    /**
    * Gets all Einstein_Datasets.
    * @return
    * An array of type Einstein_Dataset
    */
    public Einstein_Dataset[] getDatasets() {
        return getDatasets(25, 0, Einstein_Dataset.Types.ALL);
    }

    /**
    * Gets datasets based on the provided parameter for pagination and type.
    * @param count
    * Defines the number of objects that should be returned for this call. Maximum is 25.
    * @param offset
    * The offset count for dataset pagination.
    * @param typeEnum
    * The type of data that should be fetched. Either all datasets, feedback or upload.π
    * @return
    * An array of type Einstein_Dataset
    */
    public Einstein_Dataset[] getDatasets(Integer count, Integer offset, Einstein_Dataset.Types typeEnum) {
        return getDatasets(count, offset, typeEnum, false);
    }

    private Einstein_Dataset[] getDatasets(Integer count, Integer offset, Einstein_Dataset.Types typeEnum, Boolean isGlobal) {
        System.debug('Starting getDatasets call');
        String queryParameter = 'offset=' + offset + '&count='+ count + resolveEinsteinDatasetType(typeEnum);
        if (isGlobal) {
            queryParameter = 'global=true';
        }
        Einstein_HttpClient client = new Einstein_HttpClient(this, '/datasets?' + queryParameter);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getDatasets has been executed.');
        if (!client.isError()) {
            Einstein_Dataset[] datasets = (Einstein_Dataset[])client.getParser().readValueAs(Einstein_Dataset[].class);
            System.debug('Datasets have been read.');
            return datasets;
        }
//        handleError(client.getStatusCode(), client.getResponseError());
        return null;
    }

    /**
    * Gets all trained Einstein_Models that are trained for the given Einstein_Dataset id.
    * @param datasetId
    * The Einstein_Dataset id to which the Einstein_Models are assigned.
    * @return
    * An array of type Einstein_Model
    */
    public Einstein_Model[] getModels(Long datasetId) {
        System.debug('Starting getModels call');
        Einstein_HttpClient client = new Einstein_HttpClient(this, '/datasets/' + datasetId + '/models');
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getModels has been executed.');
        if (!client.isError()) {
            Einstein_Model[] models = (Einstein_Model[])client.getParser().readValueAs(Einstein_Model[].class);
            System.debug('Models have been read.');
            return models;
        }
//        handleError(client.getStatusCode(), client.getResponseError());
        return null;
    }

    /**
    * Detects objects in the given image in Base64 format based a trained model.
    * @param model
    * The Einstein_Model that should be used for the prediction.
    * @param url
    * The image url that should be used for detecting objects in it.
    * @param numResults
    * The number of results that should be max. returned.
    * @param sampleId
    * Optional. A string that gets returned as an association with the image.
    * @return
    * An object of type Einstein_PredictionResult.
    */
    public Einstein_PredictionResult detectImageUrl(String modelId, String url, Integer numResults, String sampleId) {
        System.debug('Starting detect call with model ' + modelId + ' for url');
        Einstein_HttpBodyPartPrediction parts = new Einstein_HttpBodyPartPrediction(modelId, url, numResults, sampleId, Einstein_HttpBodyPartPrediction.Types.URL);
        Einstein_HttpClient client = new Einstein_HttpClient(this, '/detect', parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call predict has been executed.');
        if (!client.isError()) {
            Einstein_PredictionResult predictions = (Einstein_PredictionResult)client.getParser().readValueAs(Einstein_PredictionResult.class);
            System.debug('Image has been detected.');
            return predictions;
        }
//        handleError(client.getStatusCode(), client.getResponseError());
        return null;
    }

    /**
    *
    * @return
    */
    public boolean isExecuting() {
        return isExecuting;
    }

    /**
    *
    * @param isExecuting
    */
    public void isExecuting(boolean isExecuting) {
        this.isExecuting = isExecuting;
    }

    /**
    *
    * @param message
    */
//    private void handleError(Integer statusCode, String message) {
//        httpStatusCode = statusCode;
//        httpErrorMessage = message;
//        System.debug(LoggingLevel.Error, 'Response finished with Error: ' + message + ' (status code: ' + statusCode + ')');
//    }

    /**
    * Sets the Type of the Einstein_PredictionService
    * @param typeEnum
    * Value of type Einstein_PredictionService.Types
    */
    public void setType(Types typeEnum) {
        this.typeEnum = typeEnum;
        this.baseUrl = resolveBaseUrl();
        this.typeString = resolveType();
    }

    private String resolveType() {
        if (this.typeEnum == Einstein_PredictionService.Types.IMAGE) {
            return 'image';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.IMAGE_MULTI_LABEL) {
//            return 'image-multi-label';
        } else if (this.typeEnum == Einstein_PredictionService.Types.IMAGE_DETECTION) {
            return 'image-detection';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.SENTIMENT) {
//            return 'text-sentiment';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.INTENT) {
//            return 'text-intent';
        }
        return '';
    }

    private String resolveBaseUrl() {
        if (this.typeEnum == Einstein_PredictionService.Types.IMAGE) {
            return BASE_URL + '/vision';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.IMAGE_MULTI_LABEL) {
//            return BASE_URL + '/vision';
        } else if (this.typeEnum == Einstein_PredictionService.Types.IMAGE_DETECTION) {
            return BASE_URL + '/vision';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.SENTIMENT) {
//            return BASE_URL + '/language';
//        } else if (this.typeEnum == Einstein_PredictionService.Types.INTENT) {
//            return BASE_URL + '/language';
        }
        return '';
    }

    private String resolveEinsteinDatasetType(Einstein_Dataset.Types typeEnum) {
        if (typeEnum == Einstein_Dataset.Types.ALL) {
            return '&type=all';
//        } else if (typeEnum == Einstein_Dataset.Types.FEEDBACK) {
//            return '&type=feedback';
//        } else if (typeEnum == Einstein_Dataset.Types.UPLOAD) {
//            return '&type=upload';
        }
        return '';
    }

    /**
    *
    * @return
    */
    public String getBearerToken() {
        return bearerToken;
    }

    public static String getAccessToken() {
        // Try to retrieve email setting
        Einstein_Settings__c settings = Einstein_Settings__c.getOrgDefaults();
        Einstein_JWT jwt = new Einstein_JWT('RS256');
        String accessToken = '';

        if (!Test.isRunningTest()) {

            if (settings.Einstein_EMail__c == null) {
                throw new Einstein_ConfigurationException('Missing Einstein email setting. Check your Custom Settings.');
            }

            if (settings.CertName__c == null) {
                ContentVersion base64Content;
                // Try to retrieve certificate
                try {
                    base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform' AND IsLatest=true LIMIT 1];
                } catch (QueryException e) {
                    throw new Einstein_ConfigurationException('Could not retrieve the Einstein Platform certificate file: einstein_platform', e);
                }

                String keyContents = base64Content.VersionData.tostring();
                keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
                keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
                keyContents = keyContents.replace('\n', '');
                jwt.pkcs8 = keyContents;
            } else {
                jwt.cert = settings.CertName__c;
            }

            // Get a new token
            jwt.iss = 'developer.force.com';
            jwt.sub = settings.Einstein_EMail__c;
            jwt.aud = OAUTH2;
            jwt.exp = '3600';      
        
            accessToken = Einstein_JWTBearerFlow.getAccessToken(OAUTH2, jwt);
        }

        return accessToken;
    }

}