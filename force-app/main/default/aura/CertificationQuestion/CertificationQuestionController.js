({
    checkAnswer: function (component, event, helper) {
        var question = component.get("v.question");
        var isValid = !question.answers.some(item => {
            return !!item.isValid !== !!item.selected;
        });
        question.answers.forEach(item => {
            item.hasError = !!item.isValid !== !!item.selected;
        });
        component.set("v.question", question);
        component.set("v.state", isValid ? "valid" : "invalid")
    },
    doOpenQuestion: function (component, event, helper) {
        Object.assign(document.createElement("a"), {
            target: "_blank",
            href: "/" + component.get("v.question.id"),
        }).click();
    }
})