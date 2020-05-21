public class AccountTriggerHelper {
    //vsc commit test
 //   public static boolean allowrun=true;
    public static Integer exec = 0;
    public static void mycityupdate(List<Account> accts,Map<Id,Account> NewMap, Map<Id,Account> OldMap){
//        System.debug('Allow Run?'+allowrun);
        System.debug('Execution No:'+exec);
   //     if(allowrun){
  //          allowrun=false;
    /*        List<Account> trigerredAccts = [Select Id,MyCity__c from Account where Id in:accts];
            List<Account> acctstoUpdate = new List<Account>(); */
            for(Account a : accts){
                System.debug('Old City:'+OldMap.get(a.Id).MyCity__c);
                System.debug('New City:'+NewMap.get(a.Id).MyCity__c);
                if(OldMap.get(a.Id).MyCity__c!='Pune' && NewMap.get(a.Id).MyCity__c=='Pune'){
                    a.MyCity__c = 'Mumbai' ;
                    System.debug('City after trigger update:'+ a.MyCity__c);
        //            acctstoUpdate.add(a);
                }
            }
            System.debug('Updating Accounts');
            exec++ ;
          //  update acctstoUpdate ;
    //    }               
    
     }
    
    public static void beforedeletehelper(){
         List<Account> acctList = [Select Id,Name,(Select Id,LastName from Contacts) from Account where Id in:Trigger.old];
               // My_TriggerOps.callbeforeDelete(acctList);
        System.debug('Inside before delete!!!');
       
        for(Account a : acctList){
            System.debug(a.Name);
            System.debug(a.contacts.size());
            
             if(a.contacts.size()>2){
                System.debug('Inside add error loop!!!');
                Trigger.OldMap.get(a.Id).adderror('cannot delete accounts with more than two contacts!!');
            }
        }
    }
    
    
 /*   public static void afteupdatehelper(List<Account> accts){
        List<Account> acctList = [Select Id,BillingAddress,BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode,(Select Id,LastName,MailingAddress,MailingStreet,MailingCity,MailingState,MailingCountry,MailingPostalCode from Contacts) from Account where id in:Trigger.New];
        List<Contact> contactstoUpdate = new List<Contact>();
        for(Account acct : acctList){
            List<Contact> ctsList = new List<Contact>(acct.contacts);
           
            if(acct.BillingAddress!=null){
                for(Contact c : ctsList){
                    System.debug(c.LastName);
                
                    c.MailingStreet = acct.BillingStreet;
    			    c.MailingCity = acct.BillingCity;
    			    c.MailingState = acct.BillingState;
    				c.MailingCountry = acct.BillingCountry;
   				    c.MailingPostalCode = acct.BillingPostalCode ;
                  
                    contactstoUpdate.add(c); 
                }
            }
        }
        
        update contactstoUpdate;
    
        
    }
    
    public static void updateContactPhone(List<Account> accts, Map<Id,Account> OldMap, Map<Id,Account> NewMap){
        List<Account> acctList = [Select Id,Phone,(Select Id,LastName,Phone,OtherPhone from Contacts) from Account where id in:accts];
        List<Contact> contactstoUpdate = new List<Contact>();
        for(Account a:acctList){
            if(OldMap.get(a.Id).Phone!=NewMap.get(a.Id).Phone){
                System.debug('Old Phone'+OldMap.get(a.Id).Phone);
                System.debug('New Phone'+NewMap.get(a.Id).Phone);
                List<Contact> contactList = new List<Contact>(a.contacts);
                for(Contact c:contactList){
                    System.debug('Last Name' + c.LastName);
                    c.Phone = NewMap.get(a.Id).Phone;
                    c.OtherPhone = OldMap.get(a.Id).Phone;
                    System.debug('Contact Phone'+ c.Phone);
                    System.debug('Contact Other Phone'+ c.OtherPhone);
                    contactstoUpdate.add(c);
                }
            }
        }
        System.debug('Updating contacts...');
        update contactstoUpdate;
    } */
}