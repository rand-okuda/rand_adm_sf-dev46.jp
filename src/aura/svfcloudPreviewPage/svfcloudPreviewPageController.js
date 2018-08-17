({

    doInit : function(component, event, helper) {
        
        var recordId = component.get("v.recordId")
        
        var urlEvent = $A.get("e.force:navigateToURL");
        
        // URLを直接指定して呼び出します。
        urlEvent.setParams({"url":"/apex/svfcloud__PreviewPage?id="+recordId+"&buttonFullName=SVFInspectioncButton20180731111818364pzt"});
        urlEvent.fire();
        
	}

})