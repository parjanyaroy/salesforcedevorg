({
	myAction : function(component, event, helper) {
        
        component.set("v.Columns",[
            {label:"Switch Name", fieldName:"SwitchName", type:"text"},
            {label:"Status", fieldName:"Status", type:"text"}
        ]);
		var action = component.get("c.getAllRelaysForSocket");
        action.setParams({
            HADeviceId : component.get("v.recordId")
        });
        action.setCallback(this, function(data){
           component.set("v.relaySwitches", data.getReturnValue()); 
        });
        $A.enqueueAction(action);
	}
})