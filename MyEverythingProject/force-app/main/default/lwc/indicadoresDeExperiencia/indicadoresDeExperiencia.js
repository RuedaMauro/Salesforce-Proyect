import { LightningElement, api, wire } from 'lwc';
import getEventoHC from '@salesforce/apex/ResumenInformacionPacienteController.getEventoHC';
import { NavigationMixin } from 'lightning/navigation';

export default class IndicadoresDeExperiencia extends NavigationMixin(LightningElement) {    
    @api recordId;
    @wire(getEventoHC, { patientId: '$recordId' })
    respuestaEventoHC;  

    navigateToEventRelatedList() {
            
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
               recordId: this.recordId,
               objectApiName: 'HealthCloudGA__EHRProcedure__c',
                relationshipApiName: 'Eventos_de_la_historia_cl_nica__pr',
                actionName: 'view'
           }
        });
    }
    
}