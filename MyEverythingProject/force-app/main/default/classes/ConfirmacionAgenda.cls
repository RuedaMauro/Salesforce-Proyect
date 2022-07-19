public without sharing class ConfirmacionAgenda {
    public ServiceAppointment agenda { get; set; }
    public Account paciente { get; set; }
    public boolean confirmaAgenda { get; set; }
    public DateTime datatimeAgenda {get;set;}
    public string tipoDePrestacion {get;set;}

    public ConfirmacionAgenda(){
        this.agenda = [SELECT Status,Confirmacion_de_agenda__c,AccountId,Nombre_sede__c, Direccion_sede__c, Ciudad_sede__c, AppointmentNumber, Fecha_y_Hora_agenda__c, Tipo_de_prestacion__c FROM ServiceAppointment 
                   WHERE Id=:ApexPages.currentPage().getParameters().get('id')];
        System.debug(agenda);
        
        this.paciente = [SELECT Id,Name FROM Account WHERE Id=:agenda.AccountId];
        System.debug(paciente);
        
        datatimeAgenda = agenda.Fecha_y_Hora_agenda__c - (1/4.8);
        
        if(agenda.Tipo_de_prestacion__c == '1'){
            tipoDePrestacion = 'Cirugía';
        }else if(agenda.Tipo_de_prestacion__c == '2'){
            tipoDePrestacion = 'Consulta Externa';
        }else if(agenda.Tipo_de_prestacion__c == '3'){
            tipoDePrestacion = 'Egresos';
        }else if(agenda.Tipo_de_prestacion__c == '4'){
            tipoDePrestacion = 'ICCAL';
        }else if(agenda.Tipo_de_prestacion__c == '5'){
            tipoDePrestacion = 'Imágenes Diagnósticas';
        }else{
            tipoDePrestacion = 'Laboratorio';
        }
            
    }
    
    
    public ServiceAppointment getAgenda(){
        return agenda;
    }
    public Account getPaciente(){
        return paciente;
    }
    
    public void confirmAgenda() {
		 
        try{ 
            this.agenda.Confirmacion_de_agenda__c = confirmaAgenda;
            if(this.agenda.Confirmacion_de_agenda__c == true){ 
               update this.agenda;
               ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM,'Gracias, su cita fue confirmada!'));   
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Por favor, antes de guardar, marque la casilla que está en el "Area de confirmación de la agenda"	'));
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Por favor, antes de guardar, marque la casilla que está en el "Area de confirmación de la agenda"	'));
        }
        
       
    }   
    
}