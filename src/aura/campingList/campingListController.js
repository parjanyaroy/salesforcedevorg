({
    doInit : function(component, event, helper) {
        var action = component.get("c.getItems");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state=="SUCCESS")
            {
                component.set("v.items",response.getReturnValue());
            }
            else
            {
                alert('Response has failed!');
            }
        });
        $A.enqueueAction(action);
    }
    ,
    /*clickCreateItem : function(component, event, helper) {
        var validItem = component.find('campingForm').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        //alert("validation :"+validItem);
        if(validItem){
            //console.log("BEFORE "+(JSON.stringify(component.get("v.items"))));
            var newItem = JSON.parse(JSON.stringify(component.get("v.newItem")));
            var allItems = component.get("v.items");
            allItems.push(newItem);
            component.set("v.items", allItems);
            //console.log("AFTER  "+(JSON.stringify(component.get("v.items"))));
            component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
          }
    }*/
    clickCreateItem : function(component, event, helper) {
        var validItem = component.find('campingForm').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validItem){
            var newItem = component.get("v.newItem");
            helper.createItem(component,newItem);
            component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
          }
    }
    
})