public class EinsteinHelper {
    
    public static Einstein_PredictionService service;
    
    private static void setType(String dataType) {
        if (service==null) {
            service = new Einstein_PredictionService(Einstein_PredictionService.Types.IMAGE);
        }
        if (dataType=='image-detection') {
            service.setType(Einstein_PredictionService.Types.IMAGE_DETECTION);
        }
    }
    
    public static List<Einstein_Dataset> getDatasets(String dataType) {
        System.debug('@@@ getDatasets()');
        System.debug('*** dataType ' + dataType);
        setType(dataType);
        List<Einstein_Dataset> datasets = service.getDatasets();
        List<Einstein_Dataset> datasetsReturn = new List<Einstein_Dataset>();
        for (Einstein_Dataset dataset : datasets) {
            datasetsReturn.add(dataset);
        }
        if (service.httpStatusCode>200) {
            System.debug('*** service.httpErrorMessage ' + service.httpErrorMessage);
        }else{
            for ( Integer i=0; i<datasetsReturn.size(); i++ ){
                System.debug('*** datasetsReturn.Id ' + datasetsReturn[i].Id);
                System.debug('*** datasetsReturn.Name ' + datasetsReturn[i].Name);
                System.debug('*** datasetsReturn.createdAt ' + datasetsReturn[i].createdAt);
                System.debug('*** datasetsReturn.updatedAt ' + datasetsReturn[i].updatedAt);
                System.debug('*** datasetsReturn.labelSummary ' + datasetsReturn[i].labelSummary);
                System.debug('*** datasetsReturn.totalExamples ' + datasetsReturn[i].totalExamples);
                System.debug('*** datasetsReturn.totalLabels ' + datasetsReturn[i].totalLabels);
                System.debug('*** datasetsReturn.available ' + datasetsReturn[i].available);
                System.debug('*** datasetsReturn.statusMsg ' + datasetsReturn[i].statusMsg);
                System.debug('*** datasetsReturn.type ' + datasetsReturn[i].type);
            }
        }
        System.debug('*** datasetsReturn ' + datasetsReturn);
        return datasetsReturn;
    }

    public static List<Einstein_Model> getModels(Long datasetId, String dataType) {
        System.debug('@@@ getModels()');
        System.debug('*** datasetId ' + datasetId);
        System.debug('*** dataType ' + dataType);
        setType(dataType);
        Einstein_Model[] models = service.getModels(datasetId);
        if (service.httpStatusCode>200) {
            System.debug('*** service.httpErrorMessage ' + service.httpErrorMessage);
        }else{
            for ( Integer i=0; i<models.size(); i++ ){
                System.debug('*** models.modelId ' + models[i].modelId);
                System.debug('*** models.name ' + models[i].name);
                System.debug('*** models.modelType ' + models[i].modelType);
                System.debug('*** models.datasetId ' + models[i].datasetId);
                System.debug('*** models.status ' + models[i].status);
                System.debug('*** models.progress ' + models[i].progress);
                System.debug('*** models.createdAt ' + models[i].createdAt);
                System.debug('*** models.updatedAt ' + models[i].updatedAt);
                System.debug('*** models.learningRate ' + models[i].learningRate);
                System.debug('*** models.epochs ' + models[i].epochs);
                System.debug('*** models.queuePosition ' + models[i].queuePosition);
                System.debug('*** models.failureMsg ' + models[i].failureMsg);
                System.debug('*** models.datasetVersionId ' + models[i].datasetVersionId);
                System.debug('*** models.type ' + models[i].type);
            }
        }
        System.debug('*** models ' + models);
        return models;
    }

    public static Einstein_PredictionResult predictImageDetectionURL(String modelId, String url) {
        System.debug('@@@ predictImageDetectionURL()');
        System.debug('*** modelId ' + modelId);
        System.debug('*** url ' + url);
        setType('');
        service.setType(Einstein_PredictionService.Types.IMAGE_DETECTION);
        Einstein_PredictionResult result = service.detectImageUrl(modelId, url, 0, '');
        if (service.httpStatusCode>200) {
            System.debug('*** service.httpErrorMessage ' + service.httpErrorMessage);
        }else{
            for ( Integer i=0; i<result.probabilities.size(); i++ ){
                System.debug('*** result.probabilities.label ' + result.probabilities[i].label);
                System.debug('*** result.probabilities.probability ' + result.probabilities[i].probability);            
            }
        }
        System.debug('*** result ' + result);
        return result;
    }

}