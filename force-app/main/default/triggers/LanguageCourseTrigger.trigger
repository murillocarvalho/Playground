trigger LanguageCourseTrigger on Language_Course__c (after insert, after update, after delete) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

    if (Trigger.isInsert) {
        System.debug('Trigger.isInsert');
        for (Language_Course__c course : Trigger.new) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {'murilloh@cielo.com.br'});
            email.setSubject('New Language Course Created');
            email.setPlainTextBody('A new language course has been created: ' + course.Name);
            emails.add(email);
        }
    } else if (Trigger.isUpdate) {
        System.debug('Trigger.isUpdate');
        for (Language_Course__c course : Trigger.new) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {'murilloh@cielo.com.br'});
            email.setSubject('Language Course Updated');
            email.setPlainTextBody('The language course has been updated: ' + course.Name);
            emails.add(email);
        }
    } else if (Trigger.isDelete) {
        System.debug('Trigger.isDelete');
        for (Language_Course__c course : Trigger.old) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {'murilloh@cielo.com.br'});
            email.setSubject('Language Course Deleted');
            email.setPlainTextBody('A language course has been deleted: ' + course.Name);
            emails.add(email);
        }
    }

    if (!emails.isEmpty()) {
        System.debug('Sending emails: ' + emails.size());
        Messaging.sendEmail(emails);
    } else {
        System.debug('No emails to send');
    }
}