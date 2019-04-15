({
    refreshCurrentObject: function (component) {
        var words = component.get("v.words");
        var index = Math.floor(Math.random() * (+words.length - +0)) + +0;
        component.set("v.currentObject", words[index]);
    },
    initObjects: function (component) {
        var self = this;
        var action = component.get("c.getLearningObjects");
        action.setParams({
            "mode": component.get("v.mode")
        });
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                if (component && component.isValid()) {
                    component.set("v.words", response.getReturnValue());
                    self.refreshCurrentObject(component);
                }
            } else {
                //TODO: add error handler
            }
        });

        $A.enqueueAction(action);
    }
})