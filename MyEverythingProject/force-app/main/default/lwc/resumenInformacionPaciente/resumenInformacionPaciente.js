import { LightningElement, api, wire } from 'lwc';
import getAcompanante from '@salesforce/apex/ResumenInformacionPacienteController.getAcompanante';
import getConvenioDelPaciente from '@salesforce/apex/ResumenInformacionPacienteController.getConvenioDelPaciente';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'account.Name', 
    'account.Tipo_de_ID__c', 
    'account.Numero_de_ID__c', 
    'account.Sexo__c',
    'account.PersonBirthdate',
    'account.Estado_civil__c', 
    'account.Edad_del_paciente__c',   
    'account.Phone',
    'account.Celular_del_Paciente__c',
    'account.PersonEmail',
    'account.Canal_de_contacto_principal__c',
    'account.Habeas_Data__c',
    'account.Donante__c',
];


export default class ResumenInformacionPaciente extends NavigationMixin(LightningElement) {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;   

    get name() {
        return this.account.data.fields.Name.value;
    }
    get Tipo_de_ID__c() {
        debugger
        return this.account.data.fields.Tipo_de_ID__c.displayValue;
    } 
    get Numero_de_ID__c() {
        return this.account.data.fields.Numero_de_ID__c.value;
    }          
    get Sexo__c() {
        return this.account.data.fields.Sexo__c.value;
    }
    get PersonBirthdate() {
        return this.account.data.fields.PersonBirthdate.value;
    }
    get Estado_civil__c() {
        return this.account.data.fields.Estado_civil__c.value;
    }
    get Edad_del_paciente__c() {
        return this.account.data.fields.Edad_del_paciente__c.value;
    }     
    get phone() {
        return this.account.data.fields.Phone.value;
    } 
    get Celular_del_Paciente__c() {
        return this.account.data.fields.Celular_del_Paciente__c.value;
    }    
    get PersonEmail() {
        return this.account.data.fields.PersonEmail.value;
    }
    get Canal_de_contacto_principal__c() {
        return this.account.data.fields.Canal_de_contacto_principal__c.value;
    }
    get Habeas_Data__c() {
        return this.account.data.fields.Habeas_Data__c.value;
    }
    get Donante__c() {
        return this.account.data.fields.Donante__c.value;
    }
     

    @wire(getAcompanante, { patientId: '$recordId' })
    nombreAcompanante;
    @wire(getConvenioDelPaciente, { patientId: '$recordId' })
    convenioDelPaciente;

    /* navigateToContact(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.contact.data.Id,
                objectApiName: 'Contact', // objectApiName is optional
                actionName: 'view'
            }
        });
    } */

    navigateToAccountContR() {
        //   Navigate to the CaseComments related list page
         //  for a specific Case record.
          this[NavigationMixin.Navigate]({
              type: 'standard__recordRelationshipPage',
              attributes: {
                 recordId: this.recordId,
                 objectApiName: 'AccountContactRelation',
                  relationshipApiName: 'AccountContactRelations',
                  actionName: 'view'
             }
          });
      }

    navigateToRelatedList() {
      //   Navigate to the CaseComments related list page
       //  for a specific Case record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
               recordId: this.recordId,
               objectApiName: 'Convenios_de_paciente__c',
                relationshipApiName: 'Convenios_de_paciente__r',
                actionName: 'view'
           }
        });
    }

}