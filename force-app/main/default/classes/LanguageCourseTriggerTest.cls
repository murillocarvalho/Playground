@isTest
public with sharing class LanguageCourseTriggerTest {
    @testSetup
    static void setup() {
        Language_Course_Instructor__c instructor = new Language_Course_Instructor__c(Name = 'Instructor');
        insert instructor;
    }
    
    @isTest
    static void testInsertTrigger() {
        // Test the insert trigger
        Test.startTest();
        Language_Course__c newCourse = new Language_Course__c(Name = 'Spanish 101', Language_Course_Instructor__c = [SELECT Id FROM Language_Course_Instructor__c WHERE Name = 'Instructor' LIMIT 1].Id);
        insert newCourse;
        System.debug('Name: ' + newCourse.Name);
        System.debug('Instructor: ' + newCourse.Language_Course_Instructor__c);
        
        // Verify that the email was sent
        Integer emailInvocations = Limits.getEmailInvocations();
        System.debug('Emails: ' + Limits.getLimitEmailInvocations());
        System.debug('Emails: ' + Limits.getEmailInvocations());
        System.assertEquals(1, emailInvocations);
        Test.stopTest();
    }
    
    @isTest
    static void testUpdateTrigger() {
        // Test the update trigger
        Language_Course__c existingCourse = new Language_Course__c(Name = 'French 101', Language_Course_Instructor__c = [SELECT Id FROM Language_Course_Instructor__c WHERE Name = 'Instructor' LIMIT 1].Id);
        insert existingCourse;
        
        Test.startTest();
        existingCourse.Name = 'French 102';
        update existingCourse;
        
        // Verify that the email was sent
        Integer emailInvocations = Limits.getEmailInvocations();
        System.assertEquals(1, emailInvocations);
        Test.stopTest();
    }
    
    @isTest
    static void testDeleteTrigger() {
        // Test the delete trigger
        Language_Course__c courseToDelete = new Language_Course__c(Name = 'German 101', Language_Course_Instructor__c = [SELECT Id FROM Language_Course_Instructor__c WHERE Name = 'Instructor' LIMIT 1].Id);
        insert courseToDelete;
        
        Test.startTest();
        delete courseToDelete;
        
        // Verify that the email was sent
        Integer emailInvocations = Limits.getEmailInvocations();
        System.assertEquals(1, emailInvocations);
        Test.stopTest();
    }
}