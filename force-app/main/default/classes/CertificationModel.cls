public with sharing class CertificationModel {
    public class Question implements Comparable {
        @AuraEnabled public String id;
        @AuraEnabled public String question;
        @AuraEnabled public String tip;
        @AuraEnabled public List<Answer> answers;
        @AuraEnabled public List<String> tips;

        public Integer compareTo(Object param1) {
            return Math.random() > 0.5 ? -1 : 1;
        }
    }

    public class Answer {
        @AuraEnabled public String answer;
        @AuraEnabled public Boolean isValid;
        @AuraEnabled public Boolean selected;
    }
}