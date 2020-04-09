public class SetRecordTypeIA {
@InvocableMethod(label='Set Record Type' 
                 description='Sets the record type for the object whose ID & API name is passed in to the Developer Name passed in. Does nothing if no recordtype can be identified using the DeveloperName')
    public static void execute (List<Request> requestList) {
       
        String recordIDToSetRTFor = requestList[0].recordIdToUpdate;
        String RTDeveloperName = requestList[0].newRecordTypeDeveloperName;
        String objectName = requestList[0].objectName;
        
        // get the record
        // 
        String query = 'SELECT Id FROM ' + objectName + ' WHERE ID = :recordIDToSetRTFor';
        sObject sobj = Database.query(query);
               
        // get recordtypeid
        
        Schema.SObjectType s = sobj.getSObjectType();
        Schema.DescribeSObjectResult d = s.getDescribe();
        Id recordTypeId = d.getRecordTypeInfosByDeveloperName().get(RTDeveloperName).getRecordTypeId();
        
        sobj.put('RecordTypeId', recordTypeId);
        update sobj;
    }

    public class Request {
        
        @InvocableVariable(required=true label='record ID')
        public String recordIdToUpdate;
        
        @InvocableVariable(required=true label='Record type DeveloperName (e.g. myRecordType)')
        public String newRecordTypeDeveloperName;
        
        @InvocableVariable(required=true label='Object API Name (e.g. myCustomObject__c)')
        public String objectName;

    }    
}