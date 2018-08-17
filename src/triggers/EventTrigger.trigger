trigger EventTrigger on Event (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){
        System.debug('%%%EventTrigger isAfter isUpdate');
        List<Event> evList = new List<Event>();
        for ( Integer i=0; i<Trigger.New.size(); i++ ){
            if(Trigger.New[i].OwnerId != Trigger.Old[i].OwnerId || Trigger.New[i].StartDateTime != Trigger.Old[i].StartDateTime){
                evList.add(Trigger.New[i]);
            }
        }
        if(evList.size() > 0){
            EventLogic.UpdateInspectionWorkerDateTime(evList);
        }
    }

}