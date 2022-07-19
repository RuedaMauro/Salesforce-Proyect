trigger FechaDeRespuesta on Case (before update, before insert ) {
if(Trigger.new[0].Reason != null){
 if (Trigger.isInsert) {
 //En caso de que se esté insertando el registro se llama al método addBusinessDays para calcular la fecha de entrega de presupuesto tomando en cuenta los días feriados
     for(Case c : Trigger.New) {
     c.Fecha_limite_de_respuesta__c = OpportunityCalculateDays.addBussinessDays(c.Fecha_de_recepcion_de_caso__c,integer.valueof(c.Tiempo_maximo_para_tramite__c));
     }
 }else if (Trigger.isUpdate) {
 // En caso que se actualizando el registro se valida si los campos Fecha_de_recepcion_de_caso__c y Tiempo_maximo_para_tramite__c, si estos cambiaron su valor, se procede a recalcular la fecha de entrega
        for(Case c : Trigger.New) {
            if(Trigger.oldMap.get( c.id).Fecha_de_recepcion_de_caso__c != Trigger.newMap.get( c.id ).Fecha_de_recepcion_de_caso__c ||
            Trigger.oldMap.get( c.id).Tiempo_maximo_para_tramite__c != Trigger.newMap.get( c.id ).Tiempo_maximo_para_tramite__c){
            c.Fecha_limite_de_respuesta__c = OpportunityCalculateDays.addBussinessDays(c.Fecha_de_recepcion_de_caso__c,integer.valueof(c.Tiempo_maximo_para_tramite__c));
            }
        }
      }
      }
}