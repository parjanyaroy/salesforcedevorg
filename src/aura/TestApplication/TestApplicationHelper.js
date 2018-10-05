({
    clearForm : function(component,helper) {
        component.set('v.sFirstName',null);
        component.set('v.sLastName',null);
        component.set('v.sEmail',null);
        component.set('v.sDOB',null);
        component.set('v.sTextArea',null);
        
    },
    changeForm : function(component,helper,isReadOnly) {
        
        var fistNameInput = component.find("firstName");
        var lastNameInput = component.find("lastName");
        var emailInput = component.find("email");
        var dobInput = component.find("dob");
        var aboutMeInput = component.find("aboutme");
        fistNameInput.set("v.disabled",isReadOnly);
        lastNameInput.set("v.disabled",isReadOnly);
        emailInput.set("v.disabled",isReadOnly);
        dobInput.set("v.disabled",isReadOnly);
        aboutMeInput.set("v.disabled",isReadOnly);
    },
    showSpinner: function (component) {
        var spinner = component.find("mySpinner");
        spinner.set("v.class"," ");
    },
    hideSpinner: function (component) {
        var spinner = component.find("mySpinner");
        spinner.set("v.class","slds-hide");
    }
    ,
    sleep : function(milliseconds) {
        var start = new Date().getTime();
        for (var i = 0; i < 1e7; i++) {
            if ((new Date().getTime() - start) > milliseconds){
                break;
            }
        }
    },
    saveContact : function(component,event){
        // c. in helper , Method in your controller. This could be a method in the JS controller or Apex Controller
        var serverCall = component.get("c.addNewContactUsingWrapper")
        //       //var serverCall = component.get("c.addNewContact")
        // Keep method name unique within Apex and JS UNIQUE
        // 
        // getting values from components
        // setting parameters : key should be same as than in apex class
        /*serverCall.setParams({ firstName:component.get('v.sFirstName') ,
                              lastName:component.get('v.sLastName') ,
                              email:component.get('v.sEmail'),
                              aboutMyself:component.get('v.sDOB')   ,
                              myDOB:component.get('v.sTextArea')   });*/
        //console.log(component.get('v.objWrapper'));
        serverCall.setParams({wrapperObject:JSON.stringify(component.get('v.objWrapper'))});
        serverCall.setCallback(this,function(response){
            var state = response.getState();
            // SUCCESS , ERROR , INCOMPLETE .. is returned in state
            console.log(response);
            if(state == "SUCCESS")
            {
                
                var returnValue = response.getReturnValue();
                //alert('Contact was inserted successfuly!')
                //this.showToast(component,event);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();
            }
            else
            {
                alert('Error!!')
            }
        });     
        $A.enqueueAction(serverCall);
    }
    ,
    showToast : function(component, event) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    },
    fetchWrapper : function(component,event)
    {
        // Below component for the contact wrapper. This would fetch a null wrapper object
        var serverCallForWrapper = component.get("c.getValues")
        serverCallForWrapper.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS")
            {
                var returnValue = response.getReturnValue();
                component.set("v.objWrapper",JSON.parse(returnValue));
                console.log("Hi "+returnValue);
            }
            else
            {alert('Error!!')}
        });     
        $A.enqueueAction(serverCallForWrapper);
    }
})