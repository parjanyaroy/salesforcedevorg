({
	getAllRooms : function(component, event, helper) {
		var action = component.get("c.getAllRoomsList");
        action.setParams({
            apartmentId : component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Rooms", data.getReturnValue());
        });
        $A.enqueueAction(action);
    }
	
})