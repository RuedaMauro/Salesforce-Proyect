import { LightningElement,api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAgendasinfo from '@salesforce/apex/ResumenInformacionPacienteController.getAgenda';
    
export default class ResumenInfoAgenda extends NavigationMixin(LightningElement) {
    @api recordId;
    agendaInfo;
    error;

    iconNameByEventName = {        
            'Agendada' : 'standard:service_appointment',
            'Reprogramada' : 'standard:schedule_objective',
            'Asistida' : 'standard:timesheet_entry',
            'NoAsistida' : 'action:defer',
            'Cancelada' : 'standard:scheduling_constraint'        
	};

    @wire(getAgendasinfo, { patientId: '$recordId' })
    respuestaAgenda;  

    navigateToAgendaRelatedList() {
       
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
               recordId: this.recordId,
               objectApiName: 'ServiceAppointment',
                relationshipApiName: 'ServiceAppointmentAccount',
                actionName: 'view'
           }
        });
    }

    @wire(getAgendasinfo, { patientId: '$recordId' })    
    wiredEvents({ error, data }) {
        if (data) {
            this.agendaInfo = JSON.parse(JSON.stringify(data));
			for (const event of this.agendaInfo) {				
                event.iconName = this.iconNameByEventName[event.Status];
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.agendaInfo = undefined;
        }
    }

    navigateToAgenda(event){        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.dataset.id,
                objectApiName: 'ServiceAppointment', 
                actionName: 'view'
            }
        });
    }
}