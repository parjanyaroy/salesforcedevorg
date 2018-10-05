({
	createItem  : function(component, newItem) {
        //alert(newItem.name);
		var action = component.get("c.saveItem");
        action.setParams({
            "newitem":newItem
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state=="SUCCESS")
            {
                var allItems = component.get("v.items");
                allItems.push(response.getReturnValue());
                component.set("v.items",allItems);
            }
            else
            {
                console.log('Response failed from server');
            }
            
        });
        $A.enqueueAction(action);
	}
})