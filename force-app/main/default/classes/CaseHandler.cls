public class CaseHandler {
	public static void handleBeforeUpdate(List<Case> updatedCases, Map<Id, Case> oldMap) {
    for (Case c : updatedCases) {
        Case oldCase = oldMap.get(c.Id);

        // Scenario: Priority changed to High
        if (c.Priority == 'High' && oldCase.Priority != 'High') {
            c.Status = 'Escalated';
        }
    }
}

public static void handleBeforeUpdate(List<Case> updatedCases, Map<Id, Case> oldMap) {
    for (Case c : updatedCases) {
        Case oldCase = oldMap.get(c.Id);

        // Scenario: Status changed to Closed
        if (c.Status == 'Closed' && oldCase.Status != 'Closed') {
            c.Closed_Date__c = Date.today();
        }
    }
}

public static void handleAfterUpdate(List<Case> updatedCases, Map<Id, Case> oldMap) {

    List<Task> tasksToInsert = new List<Task>();

    for (Case c : updatedCases) {
    
        Case oldCase = oldMap.get(c.Id);

        // Scenario: Priority changed to High
        if (c.Status == 'Closed' && oldCase.Status != 'Closed') {
            Task followUpTask = new Task();
            followUpTask.Subject = 'Send Closure date';
            followUpTask.WhatId = c.Id;
            followUpTask.OwnerId = c.OwnerId;
            followUpTask.ActivityDate = Date.today().addDays(7);
            tasksToInsert.add(followUpTask);
        }
    }

    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}
}