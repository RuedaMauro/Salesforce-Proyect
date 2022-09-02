/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
import { LightningElement,api,track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchCaseAndUpdateClient from "@salesforce/apex/CustomerSearchController.searchCaseAndUpdateClient";
import getAccountForCustomerSearchClient from "@salesforce/apex/GetAccountForCustomerSearch.getAccountForCustomerSearchClient";


var formData = [];
var typeOfDocument = 'DNI';

const clientExampleJson = [ {
    id:'ES348234988742C',
    name:"Juan",
    lastName:"Erick",
    secondLastName:"Vargas",
    birthData:{
       "birthDate":"1985-12-12"
    },
    identityDocument:{
       "documentType":{
          "id":"NIF"
       },
       "documentNumber":"12128494P"
    },
    contactDetail:{
       "contact":{
          "contactDetailType":"LANDLINE",
          "number":"916665432"
       }
    }
 } ];



 console.log(JSON.stringify(clientExampleJson));
 

export default class Crm_customer_Search extends LightningElement {   
    @api recordId; 
    @track lookupResp = {};    
    @track selectedRows;
    @track AccountRecord = {  
        name : '',
        PersonBirthdate : '',
        CRM_SCC_DocumentType__c : '',
        CRM_SCC_DocumentNumber__c : '',
        Phone : '',
    };
    
    searchValue;
    disableButton = false;
    isData = false;
    empty = false;
    hideLinkAccount = true;
    showSucessLinkAccount = false;
   
    tableClientsCols = [
        { label: 'NRO DE CLIENTE', fieldName: 'IdClient', "initialWidth": 150},
        { label: 'NOMBRE Y APELLIDO', fieldName: 'name', "initialWidth": 200},
        { label: 'NACIMIENTO', fieldName: 'birthDate' , "initialWidth": 130},
        { label: 'TIPO', fieldName: 'documentType', "initialWidth": 150},
        { label: 'N° DE DOCUMENTO', fieldName: 'documentNumber' , "initialWidth": 170},
        { label: 'TELÉFONO', fieldName: 'number', "initialWidth": 150},
        { label: 'CORREO', fieldName: 'Email', "initialWidth": 140 },      
    ];

    @wire(getAccountForCustomerSearchClient, {idCase : '$recordId' })
    getDocument({data, error}){
        if(data){
            this.searchValue = data;
            this.disableButton = true;
            this.isData = false;
            console.log(this.searchValue);
        }else{
            this.searchValue = error;
            this.disableButton = false;
        }
    }
    
    searchText(event) {
        this.searchValue = event.target.value;
        
        if(this.searchValue === ""){
            this.disableButton = false;
            this.isData = false;
        }else{
            this.disableButton = true;
        }        
    }

    searchClient(){
        let tableObj = {};
        this.lookupResp = JSON.stringify(clientExampleJson);


            for(const clientResult of clientExampleJson){
                tableObj.IdClient = clientResult.id; 
                tableObj.name = clientResult.name + ' ' + clientResult.secondLastName + ' ' + clientResult.lastName;
                tableObj.birthDate = clientResult.birthData.birthDate;
                tableObj.documentNumber = clientResult.identityDocument.documentNumber;
                tableObj.documentType = typeOfDocument;
                tableObj.number = clientResult.contactDetail.contact.number;

                formData.push(JSON.parse(JSON.stringify(tableObj)));
            }
            this.data = formData;
            formData = [];
            this.selectedRows = ['Juan Vargas Erick'];           
            this.isData = true;
    }

    newLinkAccount(){
        this.showSucessLinkAccount = false;
        this.hideLinkAccount = true;

    }

    // mensaje pop up cuenta vinculada.
    linkClient() {       
        var el; 
        var selected;
        var str
        var clientExampleJsonTest =  {
            "id":"ES348234988742C",
            "name":"Jonh",
            "lastName":"Erick",
            "secondLastName":"Vargas",
            "birthData":{
               "birthDate":"1985-10-02"
            },
            "identityDocument":{
               "documentType":{
                  "id":"NIF"
               },
               "documentNumber":"12128494P"
            },
            "contactDetail":{
               "contact":{
                  "contactDetailType":"LANDLINE",
                  "number":"916665432"
               }
            }
         };

        el = this.template.querySelector('lightning-datatable');        
        selected = el.getSelectedRows();

        console.log(el);
        console.log(selected);
        
        str = JSON.stringify(clientExampleJsonTest);

        searchCaseAndUpdateClient({
            recordIdCase : this.recordId,
            response : str        
        }).then(result => {
            this.showToast();
            window.location.reload();
            this.showSucessLinkAccount = true;
            this.hideLinkAccount = false;

            console.log(result);
        })
        .catch(error => {
            console.log('Error ',error);
        });
    }
 
    //---------------------------------------------------------
    showToast(){
        const evt = new ShowToastEvent({
            title: 'Cuenta Vinculada',
            message: 'Operación exitosa',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}