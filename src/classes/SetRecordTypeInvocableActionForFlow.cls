public class SetRecordTypeInvocableActionForFlow {
@InvocableMethod(label='Set Record Type' 
                 description='Sets the record type for the object passed in to the Developer Name passed in. Does nothing if no recordtype can be identified using the DeveloperName')
    public static void execute (List<Request> requestList) {
       
        SObject recordToSetRTFor = requestList[0].recordToUpdate;
        String RTDeveloperName = requestList[0].newRecordTypeDeveloperName;
        
        // get recordtypeid
        
        Schema.SObjectType s = recordToSetRTfor.getSObjectType();
        Schema.DescribeSObjectResult d = s.getDescribe();
        Id recordTypeId = d.getRecordTypeInfosByDeveloperName().get(RTDeveloperName).getRecordTypeId();
        
        recordToSetRTFor.put('RecordTypeId', recordTypeId);
        update recordToSetRTFor;
    }

    public class Request {
        
        @InvocableVariable(required=true)
        public sObject recordToUpdate;
        
        @InvocableVariable(required=true)
        public String newRecordTypeDeveloperName;

    }    
}