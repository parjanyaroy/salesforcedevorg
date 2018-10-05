({
    getAllSwitches : function(component, event, helper) {
        var action = component.get("c.getSwitches");
        action.setParams({
            roomId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Switches", data.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    startFlow : function (component) {
        var flow = component.find("flowData");
        var inputVariables = [
            {
                name : "recordId",
                type : "String",
                value : component.get("v.recordId")
             }
        ];
        // In that component, start your flow. Reference the flow's Unique Name.
        $A.util.removeClass(component.find("createSwitchModal"), "slds-hide");
        flow.startFlow("CreateASwitchFlow",inputVariables);
        
    }
})