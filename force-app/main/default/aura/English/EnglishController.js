({
    onChangeMode: function (component, event, helper) {
        helper.initObjects(component);
    },
    onCheckAnswer: function (component, event, helper) {
        var answer = event.getSource().get("v.name");
        var inputValue = event.getSource().get("v.value");
        if (answer.trim().toUpperCase() === inputValue.trim().toUpperCase()) {
            helper.refreshCurrentObject(component);
        }
    },
    onRefresh: function (component, event, helper) {
        helper.refreshCurrentObject(component);
    },
    onShowAnswer: function (component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Answer",
            "message": component.get("v.currentObject.answer")
        });
        toastEvent.fire();
    }
});