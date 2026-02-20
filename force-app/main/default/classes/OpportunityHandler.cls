public with sharing class OpportunityHandler {
    public static void handleAfterInsert(List<Opportunity> newOpportunities) {
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        
        for (Opportunity opp : newOpportunities) {
            if (opp.Amount >100) {
                opp.Priority__c = 'High';
                opportunitiesToUpdate.add(opp);
            }
        }
        
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }

        
    }
    
    public static void handleAfterUpdate(
    List<Opportunity> updatedOpportunities,
    Map<Id, Opportunity> oldMap
) {
    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

    for (Opportunity opp : updatedOpportunities) {

        Opportunity oldOpp = oldMap.get(opp.Id);

        // Scenario 2: Amount changed and > 100
        if (opp.Amount != oldOpp.Amount && opp.Amount > 100) {
            opp.Priority__c = 'High';
            opportunitiesToUpdate.add(opp);
        }

        // Scenario 3: Stage moved to Closed Won
        if (opp.StageName == 'Closed Won' &&
            oldOpp.StageName != 'Closed Won') {

            opp.Won_Date__c = Date.today();
            opportunitiesToUpdate.add(opp);
        }
    }

    if (!opportunitiesToUpdate.isEmpty()) {
        update opportunitiesToUpdate;
    }
}

public static void handleBeforeUpdate(List<Opportunity> updatedOpportunities, Map<Id, Opportunity> oldMap) {
    for (Opportunity opp : updatedOpportunities) {
        Opportunity oldOpp = oldMap.get(opp.Id);

        // Scenario 1: Stage moved to Closed won
        if (opp.StageName == 'Closed Won' &&
            oldOpp.StageName != 'Closed Won') {

            opp.CloseDate = Date.today();
        }
    }

}
}