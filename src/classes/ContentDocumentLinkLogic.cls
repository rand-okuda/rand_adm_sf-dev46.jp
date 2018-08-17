public class ContentDocumentLinkLogic {
    
    public static void StampPredict(List<ContentDocumentLink> targetCDLList) {
        System.debug('@@@ StampPredict()');
        
        Set<Id> LinkedEntityIdSet = new Set<Id>();
        for ( Integer i=0; i<targetCDLList.size(); i++ ){
            LinkedEntityIdSet.add(targetCDLList[i].LinkedEntityId);
            System.debug('*** targetCDLList[i] ' + targetCDLList[i]);
        }
        List<Inspection__c> existInspectionList = [SELECT Id FROM Inspection__c WHERE Id IN :LinkedEntityIdSet];
        
        if(!existInspectionList.isEmpty()){
            for(Inspection__c ip :existInspectionList){
                System.debug('*** ip ' + ip);
                String url = getImageUrlFromCDLink(ip.Id);
                if(url != null){
                    StampPredictCallOut(ip.Id, url);
                }
            }
        }
        
    }
    
    @future(callout=true)
    public static void StampPredictCallOut(Id inspectionId, String url) {
        System.debug('@@@ StampPredictCallOut()');
        System.debug('*** inspectionId ' + inspectionId);
        System.debug('*** url ' + url);
        
        List<Einstein_Dataset> edList = EinsteinHelper.getDatasets('image-detection');
        for ( Integer i=0; i<edList.size(); i++ ){
            if(edList[i].Name == 'OUIN' || Test.isRunningTest()){
                System.debug('*** edList[i].id'  + edList[i].id);
                List<Einstein_Model> modelList = EinsteinHelper.getModels(edList[i].id, 'image-detection');
                if(!modelList.isEmpty()){
                    System.debug('*** modelList[0].modelId ' + modelList[0].modelId);
                    Einstein_PredictionResult result = EinsteinHelper.predictImageDetectionURL(modelList[0].modelId, url);
                    if(!result.probabilities.isEmpty()){
                        Inspection__c ip = [SELECT Id, OUINConfirm__c FROM Inspection__c WHERE Id = :inspectionId];
                        ip.OUINConfirm__c = result.probabilities[0].label;
                        update ip;
                    }
                }
                break;
            }
        }
        
    }
    
    public static String getImageUrlFromCDLink(Id recordId) {
        System.debug('@@@ getImageURLFromCDLink()');
        List<ContentDocumentLink> cdlList = [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, SystemModstamp, ShareType, Visibility FROM ContentDocumentLink WHERE LinkedEntityId=:recordId  ORDER BY SystemModstamp DESC];
        if(!cdlList.isEmpty()){
            String excludeTitle = String.valueOf(recordId).substring(0, 15);
            System.debug('*** excludeTitle ' + excludeTitle);
            List<ContentDocument> cdList = [SELECT Id, LatestPublishedVersionId, Title, FileType, FileExtension FROM ContentDocument WHERE Id=:cdlList[0].ContentDocumentId AND Title != :excludeTitle AND FileType IN ('PNG','JPG','JPEG')];
            if(!cdList.isEmpty()){
                System.debug('*** cdList[0].Title ' + cdList[0].Title);
                List<ContentVersion> cvList = [SELECT Id, IsLatest FROM ContentVersion WHERE Id=:cdList[0].LatestPublishedVersionId AND IsLatest=true];
                if (!cvList.isEmpty()) {
                    List<ContentDistribution> existCDistList = [SELECT Id, ContentVersionId, ContentDownloadUrl FROM ContentDistribution WHERE ContentVersionId = :cvList[0].Id];
                    if(!existCDistList.isEmpty()){
                        System.debug('*** existCDistList[0].ContentDownloadUrl ' + existCDistList[0].ContentDownloadUrl);
                        return existCDistList[0].ContentDownloadUrl;
                    }
                }
            }
            return null;
        }
        return null;
    }
    
}