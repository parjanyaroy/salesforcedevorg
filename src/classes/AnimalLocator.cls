public class AnimalLocator {
    
    public static String getAnimalNameById(Integer animalId)
    {
        String animalName='';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            JSONParser parser = JSON.createParser(response.getBody());
            Integer i=1;
            while (parser.nextToken() != null) {
                //System.debug(i+++'. getText()-->'+parser.getText()+' getCurrentName()-->'+parser.getCurrentName()+' getCurrentToken()-->'+parser.getCurrentToken());
                if(parser.getText()=='name')
                {
                    parser.nextToken();
                    animalName=parser.getText();
                    break;
                }
                 }
           }
        return  animalName;
    }
}