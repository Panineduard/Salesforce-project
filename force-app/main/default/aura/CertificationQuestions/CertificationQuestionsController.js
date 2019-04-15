({
    onInit: function (component) {
        var self = this;
        var action = component.get("c.getQuestions");
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                if (component && component.isValid()) {
                    var questions = response.getReturnValue();
                    component.set("v.questions", questions);
                    component.set("v.question", questions[0]);
                }
            } else {
                //TODO: add error handler
            }
        });

        $A.enqueueAction(action);
    }
})