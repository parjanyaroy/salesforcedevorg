({
	getAllDetailsForRelay : function(component, event, helper) {
        var action = component.get("c.getRelayAttributes");
        action.setParams({
            relayId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Switches", data.getReturnValue());
        });
        $A.enqueueAction(action);
    },
})