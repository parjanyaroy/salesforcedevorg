({
    getAllSwitches : function(component, event, helper) {
        var action = component.get("c.getSwitches");
        action.setParams({
            relayId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Switches", data.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    switchClick : function(cmp,event,helper) {
        
        var whichCheckbox = event.getSource().get("v.tabindex");
        var actionTaken = event.getSource().get("v.checked");
        var action = cmp.get("c.changeSwitchState");
        action.setParams({
            switchId:whichCheckbox,
            requestedState:actionTaken
        });
        action.setCallback(this, function(data) {
            //alert(data.getReturnValue());
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                mode: 'dismissible',
                duration:'500',
                message: data.getReturnValue()[1],
                type : data.getReturnValue()[0]
            });
            toastEvent.fire();
        });
        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
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