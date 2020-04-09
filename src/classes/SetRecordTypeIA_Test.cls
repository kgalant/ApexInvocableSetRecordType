@isTest
public class SetRecordTypeIA_Test {
	@isTest
    public static void testSetRecordTypeIAForFlow() {
        Account a = new Account();
        a.Name = 'TestAccount';
        insert a;
        
 	    SetRecordTypeInvocableActionForFlow.Request req = new SetRecordTypeInvocableActionForFlow.Request();
        
		// assumes Account has at least one recordType
        Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName();
        Schema.RecordTypeInfo rtInfo = rtMap.get(new List<String>(rtMap.keySet())[0]);
        
        Id recordTypeId = rtInfo.getRecordTypeId();
        String recordTypeDevName = rtInfo.getDeveloperName();
        
        req.newRecordTypeDeveloperName = recordTypeDevName;
        req.recordToUpdate = a;
        
        List<SetRecordTypeInvocableActionForFlow.Request> reqList = new List<SetRecordTypeInvocableActionForFlow.Request>();
        reqList.add(req);
        
        SetRecordTypeInvocableActionForFlow.execute(reqList);
        
        Account newAcct = [SELECT Id, RecordTypeId FROM Account WHERE Id = :a.Id][0];
        System.assert(newAcct.RecordTypeId == recordTypeId, 'Looking for test account to have recordTypeId: ' + recordTypeId + ' (DevName: '
                     + recordTypeDevName + '), but found: ' + newAcct.RecordTypeId);
        
    }
    
    @isTest
    public static void testSetRecordTypeIA() {
        Account a = new Account();
        a.Name = 'TestAccount';
        insert a;
        
 	    SetRecordTypeIA.Request req = new SetRecordTypeIA.Request();
        
		// assumes Account has at least one recordType
        Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName();
        Schema.RecordTypeInfo rtInfo = rtMap.get(new List<String>(rtMap.keySet())[0]);
        
        Id recordTypeId = rtInfo.getRecordTypeId();
        String recordTypeDevName = rtInfo.getDeveloperName();
        
        req.newRecordTypeDeveloperName = recordTypeDevName;
        req.recordIdToUpdate = a.Id;
        req.objectName = 'Account';
        
        List<SetRecordTypeIA.Request> reqList = new List<SetRecordTypeIA.Request>();
        reqList.add(req);
        
        SetRecordTypeIA.execute(reqList);
        
        Account newAcct = [SELECT Id, RecordTypeId FROM Account WHERE Id = :a.Id][0];
        System.assert(newAcct.RecordTypeId == recordTypeId, 'Looking for test account to have recordTypeId: ' + recordTypeId + ' (DevName: '
                     + recordTypeDevName + '), but found: ' + newAcct.RecordTypeId);
        
        
        
    }
}