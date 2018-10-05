({
    getContacts: function(component) {
        var action = component.get("c.getContacts");
        action.setCallback(this, function(response) {
            component.set("v.contacts", response.getReturnValue());
            console.log("**"+response.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})