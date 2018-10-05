({
	packItem : function(component, event, helper) {
		//component.find("pckChk").set("v.checked","true");
		component.set("v.item.Packed__c","true");
        event.getSource().set("v.disabled",true);
	}
})