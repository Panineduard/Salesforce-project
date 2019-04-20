public with sharing class CertificationService {
    public static void synchroniseQuestionsAnswers(){
        Map<String, String> questionMap = new Map<String, String>();

        for (CertificationQuestion__c question : [SELECT Id, ExternalId__c, QuestionText__c FROM CertificationQuestion__c]) {
            questionMap.put(question.ExternalId__c, question.Id);
        }
        List<CertificationAnswer__c> answersForUpdate = new List<CertificationAnswer__c>();
        List<CertificationAnswer__c> answersForDelete = new List<CertificationAnswer__c>();
        List<CertificationAnswer__c> answers = [SELECT Id, ExternalId__c, CertificationQuestion__c, Value__c FROM CertificationAnswer__c];
        for (CertificationAnswer__c answer : answers) {
            if (questionMap.containsKey(answer.ExternalId__c)) {
                if (answer.Value__c.startsWithIgnoreCase('?')) {
                    answer.Value__c = answer.Value__c.removeStartIgnoreCase('?').trim();
                }
                if (answer.Value__c.startsWithIgnoreCase('A.')) {
                    answer.Value__c = answer.Value__c.removeStartIgnoreCase('A.');
                }
                if (answer.Value__c.startsWithIgnoreCase('B. ')) {
                    answer.Value__c = answer.Value__c.removeStartIgnoreCase('B.');
                }
                if (answer.Value__c.startsWithIgnoreCase('C. ')) {
                    answer.Value__c = answer.Value__c.removeStartIgnoreCase('C.');
                }
                if (answer.Value__c.startsWithIgnoreCase('D. ')) {
                    answer.Value__c = answer.Value__c.removeStartIgnoreCase('D.');
                }
                answer.Value__c = answer.Value__c.trim();
                if (String.isBlank(answer.Value__c)) {
                    answersForDelete.add(answer);
                } else {
                    answer.CertificationQuestion__c = questionMap.get(answer.ExternalId__c);
                    answersForUpdate.add(answer);
                }
            }
        }
        update answersForUpdate;
        delete answersForDelete;
        System.debug(answersForUpdate.size() + ' have been updated.');
        System.debug(answersForDelete.size() + ' have been deleted.');
    }

    public static List<CertificationModel.Question> getQuestions () {
        List<CertificationModel.Question> result = new List<CertificationModel.Question>();
        for (CertificationQuestion__c certificationQuestion : [SELECT Id, QuestionText__c, Tip__c, RightAnswersCount__c,  (SELECT Value__c, IsRightAnswer__c FROM CertificationAnswers__r ORDER BY Value__c), (SELECT Resource__c FROM Tips__r) FROM CertificationQuestion__c]) {
            CertificationModel.Question question = new CertificationModel.Question();
            question.question = certificationQuestion.QuestionText__c;
            question.tip = certificationQuestion.Tip__c;
            question.id = certificationQuestion.Id;
            question.answers = new List<CertificationModel.Answer>();
            question.tips = new List<String>();
            for (CertificationAnswer__c certificationAnswer : certificationQuestion.CertificationAnswers__r) {
                CertificationModel.Answer answer = new CertificationModel.Answer();
                answer.answer = certificationAnswer.Value__c;
                answer.isValid = certificationAnswer.IsRightAnswer__c == 1;
                question.answers.add(answer);
            }
            for (Tip__c tip : certificationQuestion.Tips__r) {
                question.tips.add(tip.Resource__c);
            }
            result.add(question);
        }
        result.sort();
        return result;
    }
}