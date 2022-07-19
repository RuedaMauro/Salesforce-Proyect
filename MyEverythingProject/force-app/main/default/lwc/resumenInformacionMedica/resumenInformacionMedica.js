import { LightningElement,api, wire } from 'lwc';
import getDiagnosticosPaciente from '@salesforce/apex/ResumenInformacionPacienteController.getDiagnosticosDelPaciente';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'account.Antecedentes_del_Paciente__c',     
];


export default class ResumenInformacionMedica extends NavigationMixin(LightningElement) {
    @api recordId;
    @wire(getDiagnosticosPaciente, { patientId: '$recordId' })
    diagnosticosPacienteaciente;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;   

    get Antecedentes_del_Paciente__c() {
        return this.account.data.fields.Antecedentes_del_Paciente__c.value;
    }
    
    navigateToRelatedListDiagnosticosPaciente() {
        
          this[NavigationMixin.Navigate]({
              type: 'standard__recordRelationshipPage',
              attributes: {
                 recordId: this.recordId,
                 objectApiName: 'Account',
                  relationshipApiName: 'Diagnosticos_de_pacientes__r',
                  actionName: 'view'
             }
          });
      }
}