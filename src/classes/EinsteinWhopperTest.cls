@isTest
private class EinsteinWhopperTest {
    
    @isTest
    static void UnitTest099() {
        Einstein_HttpBodyPart.WriteBodyParameter('key', 57);
        Einstein_HttpBodyPartPrediction bodyPartPrediction = new Einstein_HttpBodyPartPrediction('modelId1', 'testData1', 0, '', Einstein_HttpBodyPartPrediction.TYPES.BASE64);
        bodyPartPrediction.getModelId();
        bodyPartPrediction.getData();
        bodyPartPrediction.getSampleId();
        bodyPartPrediction.getType();
        bodyPartPrediction.getNumResults();
    }
    
    @isTest
    static void UnitTest100() {
        Einstein_JWT jwt = new Einstein_JWT('a');
        jwt.iss = 'b';
        jwt.sub = 's';
        jwt.aud = 'c';
        jwt.exp = 'd';
        jwt.iat = 'e';
        jwt.validFor = 1;
        jwt.cert = 'f';
        jwt.pkcs8 = 'g';
        jwt.privateKey = 'h';
        jwt.issue();
        Blob input = Blob.valueOf('XXX');
        jwt.base64URLencode(input);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new EinsteinWhopperGetAccessTokenMock());
        String tokenEndpoint = 'http://token.endpoint/tokenEndpoint';
        Einstein_JWTBearerFlow.getAccessToken(tokenEndpoint, jwt);
        Test.stopTest();
    }
    
    @isTest
    static void UnitTest101() {
        Einstein_Label el = new Einstein_Label();
        el.datasetId = 99;
        el.id = 99;
        el.name = 'name';
        el.numExamples = 99;
        List<Einstein_Label> elList = new List<Einstein_Label>();
        elList.add(el);
        Einstein_LabelSummary els = new Einstein_LabelSummary();
        els.labels = elList;
    }
    
}