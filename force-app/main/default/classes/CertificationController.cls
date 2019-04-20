public with sharing class CertificationController {

    @AuraEnabled(Cacheable=true) public static List<CertificationModel.Question> getQuestions(){
       return CertificationService.getQuestions();
    }
}