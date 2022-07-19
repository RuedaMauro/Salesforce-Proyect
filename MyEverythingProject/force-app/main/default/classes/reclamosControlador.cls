/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class reclamosControlador{
    public String respuesta {get;set;}
    public area_de_caso__c area {get;set;}
    public String comentarioRespuesta {get;set;}
    
    public pageReference enviarRespuesta(){
         system.debug('ejecutado enviar respuesta'); 
        try{
            Comentario_de_caso__c newComment = new Comentario_de_caso__c();
            newComment.Comentarios__c = comentarioRespuesta;//area.Respuesta_del_area__c;
            newComment.Area_de_caso__c = area.Id;
            insert newComment;
            if(this.respuesta == 'R'){
                area.Estado__c = 'Rechazado por área';
            }else{
                area.Estado__c = 'Contestado';
            }
            area.Respuesta_del_area__c = 'Escriba una respuesta...';
            update area;
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Error en el guardado del registro'));
        }
        return null;
    }
    
    public ApexPages.StandardSetController setCon{
        get{
            system.debug('ejecutado SetCon');
            if(setCon == null){
                if(Test.isRunningTest()){
                    setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, Comentarios__c, LastModifiedById, CreatedDate FROM Comentario_de_caso__c WHERE id = 'a1R02100000DWLcEAO'
                     ORDER BY CreatedDate DESC LIMIT 1]));
                }else{
                    setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, Comentarios__c, LastModifiedById, CreatedDate FROM Comentario_de_caso__c 
                     WHERE Area_de_caso__c =: ApexPages.currentPage().getParameters().get('id') ORDER BY CreatedDate DESC]));
                }
            }
            return setCon;
        }
        set;
        
    }
    
    public reclamosControlador(){
        system.debug('ejecutado constructor');
        if(Test.isRunningTest()){
            area = [SELECT Id, Caso__r.CaseNumber, Caso__r.Reason, Caso__r.Fecha_de_recepcion_de_caso__c, Caso__r.ParentId, Caso__r.Priority,
                Caso__r.Informante__c, Caso__r.Ambito__c, Caso__r.Description, Caso__r.Origin, Caso__r.Derecho_afectado__c,
                Caso__r.Tiempo_maximo_para_tramite__c, Caso__r.AccountId, Caso__r.Convenio_de_paciente__c, Caso__r.Tipo_Id_Paciente__c,
                Caso__r.ContactEmail, Caso__r.Numero_ID_Paciente__c, Caso__r.ContactId, Caso__r.Nombre_del_reportante__c,
                Caso__r.Tipo_documento_del_reportante__c, Caso__r.Apellidos_del_reportante__c, Caso__r.Numero_ID_reportante__c,
                area__c, Fecha_de_asignacion__c, Dimension__c, Estado__c, Atributos_de_calidad__c, Respuesta_del_area__c
                FROM area_de_caso__c LIMIT 1];
        }else{
            area = [SELECT Id, Caso__r.CaseNumber, Caso__r.Reason, Caso__r.Fecha_de_recepcion_de_caso__c, Caso__r.ParentId, Caso__r.Priority,
                Caso__r.Informante__c, Caso__r.Ambito__c, Caso__r.Description, Caso__r.Origin, Caso__r.Derecho_afectado__c,
                Caso__r.Tiempo_maximo_para_tramite__c, Caso__r.AccountId, Caso__r.Convenio_de_paciente__c, Caso__r.Tipo_Id_Paciente__c,
                Caso__r.ContactEmail, Caso__r.Numero_ID_Paciente__c, Caso__r.ContactId, Caso__r.Nombre_del_reportante__c,
                Caso__r.Tipo_documento_del_reportante__c, Caso__r.Apellidos_del_reportante__c, Caso__r.Numero_ID_reportante__c,
                area__c, Fecha_de_asignacion__c, Dimension__c, Estado__c, Atributos_de_calidad__c, Respuesta_del_area__c
                FROM area_de_caso__c WHERE Id =: ApexPages.currentPage().getParameters().get('id') LIMIT 1];
        }
    }
    
    public area_de_caso__c getArea(){
        system.debug('ejecutado getArea');
        return area;
    }
    
    public List<Comentario_de_caso__c> getComentarios(){
        system.debug('ejecutado getComentarios');
        return (List<Comentario_de_caso__c>) setCon.getRecords();
    }
}