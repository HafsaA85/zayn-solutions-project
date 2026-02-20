trigger CaseTrigger on Case (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        CaseHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        CaseHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}