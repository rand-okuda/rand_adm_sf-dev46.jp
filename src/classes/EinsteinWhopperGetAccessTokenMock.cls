@isTest
global class EinsteinWhopperGetAccessTokenMock implements HttpCalloutMock{
    
    public EinsteinWhopperGetAccessTokenMock(){
        System.debug('### EinsteinWhopperGetAccessTokenMock()');
    }
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setStatus('OK');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeEndObject();
        String bodyJSON = gen.getAsString();
        response.setBody(bodyJSON);
        System.debug('### response ' + response);
        return response; 
    }
    
}