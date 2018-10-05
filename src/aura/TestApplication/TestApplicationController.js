({
    myAction : function(component, event, helper) {
        //helper.showSpinner(component);
        var firstName='Pratik';
        var lastName='Saha'
        var email='abc@def.com';
        var today = new Date();
        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        console.log("Sample Console Log: " + firstName);
        component.set('v.sFirstName',firstName);
        component.set('v.sLastName',lastName);
        component.set('v.sEmail',email);
        component.set('v.sDOB',date);
        
        var currentStatus = component.get('v.sFormStatus');
        var buttonMessage = currentStatus ? "Unlock Form" : "Lock Form";
        var formActionButtonText = component.find("formActionButton");
        formActionButtonText.set("v.label",buttonMessage);
        helper.fetchWrapper(component,event);
    }
    ,
    enableField : function(component, event, helper) {
        alert('Enabling field');
        var fistNameImput = component.find("firstName");
        fistNameImput.set("v.disabled",false);   
    }
    ,
    clearForm : function(component, event, helper) {
        helper.clearForm(component,helper);
    }
    ,
    toggleStatus : function(component, event, helper) {
        helper.showSpinner(component);
        var currentStatus = component.get('v.sFormStatus');
        currentStatus=!currentStatus;
        helper.changeForm(component,helper,currentStatus);
        component.set('v.sFormStatus',currentStatus);
        var buttonMessage = currentStatus ? "Unlock Form" : "Lock Form";
        var formActionButtonText = component.find("formActionButton");
        formActionButtonText.set("v.label",buttonMessage);
        helper.sleep(1000);
        helper.hideSpinner(component);
        
    },
    handleSave : function(component, event, helper)
    {
        helper.saveContact(component, event);
    }
    
})