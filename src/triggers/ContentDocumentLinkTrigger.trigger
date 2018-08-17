trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) {
    System.debug('%%% ContentDocumentLinkTrigger');
    
    List<ContentDocumentLink> targetCDLList = new List<ContentDocumentLink>();
    for ( Integer i=0; i<Trigger.New.size(); i++ ){
        if(Trigger.New[i].ShareType == 'V'){
            targetCDLList.add(Trigger.New[i]);
        }
    }
    if(!targetCDLList.isEmpty()){
        ContentDocumentLinkLogic.StampPredict(targetCDLList);
    }
    
}