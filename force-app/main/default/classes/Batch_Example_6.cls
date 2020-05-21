global class Batch_Example_6 implements Database.Batchable<sobject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query='select Id,Name,Rating from Account';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<Account> scope){
        
        for(Account a: scope){
            
            Boolean status=true;
            a.rating='Cold';
            
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
        Id jobId =bc.getJobId();
        AsyncApexJob ac=[SELECT NumberOfErrors,JobType,Status,TotalJobItems FROM AsyncApexJob where id=:jobId];
        Messaging.SingleEmailMessage msg =new Messaging.SingleEmailMessage();
        String[] toadd =new String[]{'renjith.rgn1@gmail.com'};
        msg.setToAddresses(toadd);
        String body='Job Type :'+ac.jobType;
        body=body+'<br/><br/> Total JobItems:'+ac.TotalJobItems;
        body=body+'<br/><br/> No of Errors :'+ac.NumberOfErrors;
        msg.setSubject('batch job '+jobId+' '+ac.status);
        msg.setHtmlBody(body);
        Messaging.Email[] emails =new Messaging.Email[]{msg};
        Messaging.sendEMail(emails);
    }

}