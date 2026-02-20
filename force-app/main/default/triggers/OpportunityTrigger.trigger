trigger OpportunityTrigger on Opportunity (after insert, after update, before update) {
    
    if (Trigger.isInsert && Trigger.isAfter) {
        OpportunityHandler.handleAfterInsert(Trigger.new);
    }
    
    if (Trigger.isUpdate && Trigger.isAfter) {
        OpportunityHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
    
    if (Trigger.isUpdate && Trigger.isBefore) {
        OpportunityHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
}