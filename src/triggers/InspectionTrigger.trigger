trigger InspectionTrigger on Inspection__c (before insert, after insert, after update) {

    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('%%%InspectionTrigger isBefore isInsert');
        List<Inspection__c> inspectionList = new List<Inspection__c>();
        for(Inspection__c ip :Trigger.new){
            inspectionList.add(ip);
        }
        InspectionLogic.RecordTypeChanger(inspectionList);        
    }

    if(Trigger.isAfter && Trigger.isInsert){
        System.debug('%%%InspectionTrigger isAfter isInsert');
        List<Inspection__c> inspectionList = new List<Inspection__c>();
        for(Inspection__c ip :Trigger.new){
            inspectionList.add(ip);
        }
        InspectionLogic.QRcodeImageToGet(inspectionList);                
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        System.debug('%%%InspectionTrigger isAfter isInsert');
        List<Inspection__c> ChangeScheduleInspectionList = new List<Inspection__c>();
        for(Inspection__c ipNew :Trigger.new){
            if(ipNew.InspectionDateTime__c != null && ipNew.Worker__c != null){
                ChangeScheduleInspectionList.add(ipNew);
            }
        }
        if(ChangeScheduleInspectionList.size() > 0){
            InspectionLogic.CreateInspectionActivity(ChangeScheduleInspectionList);                
        }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        System.debug('%%%InspectionTrigger isAfter isUpdate1 [1]');
        List<Inspection__c> ChangeScheduleInspectionList = new List<Inspection__c>();
        for ( Integer i=0; i<Trigger.New.size(); i++ ){
            if(Trigger.New[i].InspectionDateTime__c != Trigger.Old[i].InspectionDateTime__c || Trigger.New[i].Worker__c != Trigger.Old[i].Worker__c && Trigger.New[i].InspectionDateTime__c != null && Trigger.New[i].Worker__c != null){
                ChangeScheduleInspectionList.add(Trigger.New[i]);
            }
        }
        if(ChangeScheduleInspectionList.size() > 0){
            InspectionLogic.CreateInspectionActivity(ChangeScheduleInspectionList);                
        }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        System.debug('%%%InspectionTrigger isAfter isUpdate [2]');
        List<Inspection__c> CompletedInspectionList = new List<Inspection__c>();
        for ( Integer i=0; i<Trigger.New.size(); i++ ){
            if(Trigger.New[i].InspectionCompleted__c != Trigger.Old[i].InspectionCompleted__c){
                CompletedInspectionList.add(Trigger.New[i]);
            }
        }
        if(CompletedInspectionList.size() > 0){
            InspectionLogic.CreateNextInspection(CompletedInspectionList);
            InspectionLogic.DeleteEvent(CompletedInspectionList);
        }
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        System.debug('%%%InspectionTrigger isAfter isUpdate [3]');
        List<Inspection__c> PDFOutputInspectionList = new List<Inspection__c>();
        for(Inspection__c ipNew :Trigger.new){
            if(ipNew.TablePDFOutput__c){
                PDFOutputInspectionList.add(ipNew);
            }
        }
        if(PDFOutputInspectionList.size() > 0){
            InspectionLogic.CreateInspectionPDF(PDFOutputInspectionList);
        }
    }
    
}