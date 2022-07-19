import { LightningElement,api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getEventosDeLaHistoria from '@salesforce/apex/ResumenInformacionPacienteController.getEventosDeLaHistoriaClinica';
import getEventoHC from '@salesforce/apex/ResumenInformacionPacienteController.getEventoHC';

export default class ResumenInformacionPaciente extends NavigationMixin(LightningElement) {
    @api recordId;
     eventosDeLaHistoriaClinica;
     error;   

    iconNameByEventName = {
		'URGENCIAS' : 'standard:incident',
		'AMBULATORIO' : 'standard:service_appointment',
        'IMAGENOLOGIA' : 'standard:person_name',
        'REHABILITACION CARDIACA' : 'standard:unified_health_score',
        'CIRUGIA' : 'custom:custom70',
        'MIXTO' : 'standard:activations',
        'HOSPITALARIO' : 'standard:process_exception',
        'ATENCIÓN PRIORITARIA' : 'custom:custom94',
        'CLINICA DE HERIDAS' : 'standard:cms',
        'PROCEDIMIENTOS MEDICOS' : 'standard:bot_training',
        'CHEQUEOS EJECUTIVOS' : 'action:new_child_case',
        'QUIMIOTERAPIA' : 'standard:asset_relationship',
        'RADIOTERAPIA' : 'standard:actions_and_buttons',
        'NUTRICION Y DIETETICA' : 'standard:service_resource',
        'NINGUNO' : 'standard:empty',
        '' : 'standard:empty',
	};

   
    @wire(getEventosDeLaHistoria, { patientId: '$recordId' })    
    wiredEvents({ error, data }) {
        if (data) {
            this.eventosDeLaHistoriaClinica = JSON.parse(JSON.stringify(data));
			for (const event of this.eventosDeLaHistoriaClinica) {				
                event.iconName = this.iconNameByEventName[event.Tipo_de_Evento_Ambito__c];
			}
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.eventosDeLaHistoriaClinica = undefined;
        }
    }

    @wire(getEventoHC, { patientId: '$recordId' })
    respuestaEventoHC;  

    navigateToEventRelatedList() {
      //   Navigate to the ServiceAppointment "Eventos de la Historia Clinica" related list page       
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
               recordId: this.recordId,
               objectApiName: 'HealthCloudGA__EHRProcedure__c',
                relationshipApiName: 'EHRProcedures',
                actionName: 'view'
           }
        });
    }
    
    navigateToEvent(event){
        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.dataset.id,
                objectApiName: 'HealthCloudGA__EHRProcedure__c', 
                actionName: 'view'
            }
        });
    }
}