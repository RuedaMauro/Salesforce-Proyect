trigger CaseTrigger on Case (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
	CaseTriggerHandler.handleTrigger(Trigger.new, Trigger.old, Trigger.operationType);
}