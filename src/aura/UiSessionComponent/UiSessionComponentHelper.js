({
	 showExampleModal : function(component) {      
        var modal = component.find("exampleModal");
        $A.util.removeClass(modal, 'hideDiv');        
         //alert('show');
    },
    
    hideExampleModal : function(component) {
        //alert('hide');
        var modal = component.find("exampleModal");
        $A.util.addClass(modal, 'hideDiv');
    }
})