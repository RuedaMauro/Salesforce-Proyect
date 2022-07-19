/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-06-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
import { LightningElement, track, api, wire } from 'lwc';
import { getPicklistValues, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
//APEX CONTROLLERS
import solicitarPresupuesto from '@salesforce/apex/AccountCreationController.solicitarPresupuesto';
import solicitarPresupuestoWithoutAcc from '@salesforce/apex/AccountCreationController.solicitarPresupuestoWithoutAcc';
import checkExistingSolicitante from '@salesforce/apex/AccountCreationController.checkExistingSolicitante';
import getDataLookup from '@salesforce/apex/AccountCreationController.getDataLookup';
import getProfesional from '@salesforce/apex/AccountCreationController.getProfesional';
import uploadFile from '@salesforce/apex/AccountCreationController.uploadFile';
//IMAGES
import LOGO_FSFB from '@salesforce/resourceUrl/LogoFSFB';
//OBJECTS
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
// OPPORTUNITY FIELDS
import TIENE_ORDEN_MEDICA from '@salesforce/schema/Opportunity.Tiene_orden_medica__c';
import TIPO_DE_SOLICITANTE from '@salesforce/schema/Opportunity.Tipo_de_solicitante__c';
import TIPO_DE_ANESTESIA from '@salesforce/schema/Opportunity.Tipo_de_anestesia__c';
import TIPO_DE_ESTANCIA from '@salesforce/schema/Opportunity.Tipo_de_estancia__c';
import TIPO_DE_DOCUMENTO_A from '@salesforce/schema/Opportunity.Tipo_de_documento_del_acudiente__c';
import MEDIO_DE_SOLICITUD from '@salesforce/schema/Opportunity.Canal_de_solicitud__c';
// ACCOUNT FIELDS
import TIPO_DE_ID from '@salesforce/schema/Account.Tipo_de_ID__c';
import NUMERO_DE_DOCUMENTO from "@salesforce/schema/Account.Numero_de_ID__c";
import SEXO_PACIENTE from '@salesforce/schema/Account.Sexo__c';
import PAIS_DE_RESIDENCIA from "@salesforce/schema/Account.Pais_de_residencia__c";

export default class formFSFB extends LightningElement {

    @api recordId;
    @api cedNum;
    @api itemsSelected = [];
    @api ProfSelected = [];

    @track fileData;
    @track error;
    @track accountMetadata;
    @track productName = '';
    @track isShow = false;
    @track messageResult = false;
    @track isShowResult = true;
    @track showSearchedValues = false;
    @track currentAccountName;
    @track searchAccountName;

    @track opportunityRecord = {
        Canal_de_solicitud__c: '',
        Tipo_de_solicitante__c: '',
        Tiene_orden_medica__c: '',
        Informacionode_la_solicitud__c: '',
        Tipo_de_anestesia__c: '',
        Tiempo_estimado_de_duracion__c: '',
        Description: '',
        Tipo_de_estancia__c: '',
        Tipo_de_documento_del_acudiente__c: '',
        Dias_de_estancia_piso__c: ''
    }

    @track accountRecord = {
        FirstName: '',
        LastName: '',
        Celular_del_Paciente__c: '',
        Sexo__c: '',
        PersonBirthdate: '',
        Tipo_de_ID__c: '',
        Numero_de_ID__c: '',
        Pais_de_residencia__c: '',
        Ciudad_de_residencia__c: '',
        Numero_telefonico_de_contacto_adicional__c: '',
        PersonEmail: ''
    }

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountMetadata;

    @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
    opportunityMetadata;

    @wire(getPicklistValues, {
        recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId',
        fieldApiName: TIPO_DE_ANESTESIA
    })
    getTipoDeAnest;

    @wire(getPicklistValues, {
        recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId',
        fieldApiName: TIPO_DE_DOCUMENTO_A
    })
    getTipoDocAcudiente;

    @wire(getPicklistValues, {
        recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId',
        fieldApiName: TIPO_DE_ESTANCIA
    })
    getEstancia;

    @wire(getPicklistValues, {
        recordTypeId: '0125f000000N30CAAS',
        fieldApiName: TIENE_ORDEN_MEDICA
    })
    getPickListTieneOrdMed;

    @wire(getPicklistValues, {
        recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId',
        fieldApiName: TIPO_DE_SOLICITANTE
    })
    getPickListTipoDeSolic;

    @wire(getPicklistValues, {
        recordTypeId: '$accountMetadata.data.defaultRecordTypeId',
        fieldApiName: PAIS_DE_RESIDENCIA
    })
    PickListPaisDeRes;

    @wire(getPicklistValues, {
        recordTypeId: '$accountMetadata.data.defaultRecordTypeId',
        fieldApiName: NUMERO_DE_DOCUMENTO
    })
    getPickListNumDeDoc;

    @wire(getPicklistValues, {
        recordTypeId: '$accountMetadata.data.defaultRecordTypeId',
        fieldApiName: SEXO_PACIENTE
    })
    pickListValues;

    @wire(getPicklistValues, {
        recordTypeId: '$opportunityMetadata.data.defaultRecordTypeId',
        fieldApiName: MEDIO_DE_SOLICITUD
    })
    getPickListMedioDeSolic;

    @wire(getPicklistValues, {
        recordTypeId: '$accountMetadata.data.defaultRecordTypeId',
        fieldApiName: TIPO_DE_ID
    })
    getPickListTipoDeId;

    get options() {
        return [
            { label: 'Si', value: 'Si' },
            { label: 'No', value: 'No' },
        ];
    }

    get optionsValues(){
        return [
            { label: 'Persona Natural en nombre propio (paciente)', value: 'Persona Natural en nombre propio (paciente)' },
            { label: 'Médico Profesional FSFB', value: 'Médico Profesional FSFB' },
            { label: 'Admisiones', value: 'Admisiones' },
            { label: 'Contact Center', value: 'Contact Center' },
            { label: 'Central de Autorizaciones', value: 'Central de Autorizaciones' },
            { label: 'Convenio', value: 'Convenio' },
            { label: 'Referencia', value: 'Referencia' },
        ];
    }
     
    get optionsMedioSolicitud() {
        return [
            { label: 'Web', value: 'Web' },
        ];
    }

    lgFSFB = LOGO_FSFB + '/logo_fsfb.jpg';
    accepTerm = false;  // Accep term and coditions 
    isProfessional = true;
    solicPresu = false;
    isSolicitante = false;
    ordenMed = true;
    isValid = false;
    alertString;
    nullElements = [];
    nullElementValues = [];
    validCedNumb = false;
    needsId = true;

    //---------------------------------------------------------------------
    // OPPORTUNITY HANDLERS
    //----------------------------------------------------------------------
    
    handleChangeCanalSolic(event) {
        this.opportunityRecord.Canal_de_solicitud__c = event.target.value;
        if(event.detail.value === 'Web') {
            this.ordenMed = true;
        }else {
            this.ordenMed = false;
        }
    }
    handleClick(event) {    
        this.accepTerm = event.target.checked;
    }
    handleTieneOrdenMedChange(event) {
        this.opportunityRecord.Tiene_orden_medica__c = event.target.value;
    }
    handleInfoSolic(event) {
        this.opportunityRecord.Informacionode_la_solicitud__c = event.target.value;
    }
    handleTiempoDurac(event) {
        this.opportunityRecord.Tiempo_estimado_de_duracion__c = event.target.value;
    }
    handleMedicoQ(event) {
        this.opportunityRecord.Medico_quien_ordena__c = event.target.value;
        if (event.detail.value === 'Médico Profesional FSFB' || event.detail.value === 'Funcionario Oficina de Presupuestos') {
            this.isProfessional = false;
        }
    }
    handleTipoA(event) {
        this.opportunityRecord.Tipo_de_documento_del_acudiente__c = event.target.value;
    }
    handleNumeroA(event) {
        this.opportunityRecord.Numero_de_documento_del_acudiente__c = event.target.value;
    }
    handleAcudiente(event) {
        this.opportunityRecord.Nombre_acudiente_del_paciente__c = event.target.value;
    }
    handleEps(event) {
        this.opportunityRecord.EPS_del_paciente__c = event.target.value;
    }
    handleConvenio(event) {
        this.opportunityRecord.Convenio_reportado_en_el_formulario__c = event.target.value;
    }
    handleDescription(event) {
        this.opportunityRecord.Description = event.target.value;
    }
    handleTipoDeAnest(event) {
        this.opportunityRecord.Tipo_de_anestesia__c = event.target.value;
    }
    handleTipoDocA(event) {
        this.opportunityRecord.Tipo_de_documento_del_acudiente__c = event.target.value;        
        console.log('tipo ' + opportunityRecord.Tipo_de_documento_del_acudiente__cc, 'value ' + event.target.value);
    }
    handleTipoDeEstanc(event) {
        this.opportunityRecord.Tipo_de_estancia__c = event.target.value;
    }
    handleTipodeestancUCIInter(event) {
        this.opportunityRecord.Dias_de_estancia_en_UCI_intermedia__c = event.target.value;
    }
    handleTipodeestancPiso(event) {
        this.opportunityRecord.Dias_de_estancia_piso__c = event.target.value;
    }
    handleTipoEstanciacUCI(event) {
        this.opportunityRecord.Dias_de_estancia_UCI__c = event.target.value;
    }
    handleChangeTipoDeSolic(event) {
        this.opportunityRecord.Tipo_de_solicitante__c = event.target.value;
        if (event.detail.value === 'Médico Profesional FSFB' || event.detail.value === 'Funcionario Oficina de Presupuestos') {
            this.isProfessional = true;
        }else {
            this.isProfessional = false;
        }
    }
   

    //----------------------------------------------------------------------
    // PATIENT HANDLERS
    //----------------------------------------------------------------------
    handleFirstnameChange(event) {
        this.accountRecord.FirstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.accountRecord.LastName = event.target.value;
    }
    handleTipoDeDocumChange(event) {
        this.accountRecord.Tipo_de_ID__c = event.target.value;
        if(event.target.value == 'A'){
            this.needsId = false;
        }else{
            this.needsId = true;
        }
        console.log('Account ' + this.accountRecord.Tipo_de_ID__c, 'value ' + event.target.value);
    }
    handleNumeroDeDocumentoChange(event) {
        this.accountRecord.Numero_de_ID__c = event.target.value;
    }
    handleFechaDeNacimHandle(event) {
        this.accountRecord.PersonBirthdate = event.target.value;
    }
    handleSexoDelPacienteChange(event) {
        this.accountRecord.Sexo__c = event.target.value;
    }
    handlePaisdeResidenciaChange(event) {
        this.accountRecord.Pais_de_residencia__c = event.target.value;
    }
    handleCiudadDeResChange(event) {
        this.accountRecord.Ciudad_de_residencia__c = event.target.value;
    }
    handleCorreoElectronicoChange(event) {
        this.accountRecord.PersonEmail = event.target.value;
    }
    handleNumeroDeTelefonoChange(event) {
        this.accountRecord.Celular_del_Paciente__c = event.target.value;
    }
    handleNumeroAdicionalChange(event) {
        this.accountRecord.Numero_telefonico_de_contacto_adicional__c = event.target.value;
    }
    handleNumDeCedPatient(event) {
        this.cedNum = event.target.value;
        checkExistingSolicitante({
            numCed : event.target.value
        }).then(result => {
            console.log(result);
            if(result === null){
                this.validCedNumb = false;
            }else if(result == 'No valido'){
                this.validCedNumb = false;
            }else{
                this.validCedNumb = true;
                this.accountRecord.Tipo_de_ID__c = result;
            }
        })
        .catch(error => {
            console.log('Error ',error);
            alert(error.body.message);
        });
    }
    handleChangeIsSolic(event) {
        if (event.detail.value === 'Si') {
            this.isSolicitante = true;
            this.solicPresu = true;
        } else if (event.detail.value === 'No') {
            this.isSolicitante = false;
            this.solicPresu = false;
        }
    }

    //---------------------------------------------------------------------
    // SAVE HANDLER
    //----------------------------------------------------------------------

    handleCreatePresupuestoWithAcc(){
        this.handleValidate();
        if(this.isValid){
            solicitarPresupuesto({
                cuentaMap : this.accountRecord,
                oppMap : this.opportunityRecord,
                numCed : this.cedNum,
                cedProf : this.ProfSelected,
                items : this.itemsSelected
            }).then(result => {
                alert(result.Name + '\nEsta es la información de su presupuesto, cuando de click en OK esta ventana será cerrada y su información será procesada.');
                this.recordId = result.Id;
                this.uploadAttachment();
                window.close();
            })
            .catch(error => {
                console.log('Error ',error);
                alert(error.body.message);
            });
        }
    }

    handleCreatePresupuestoWithNoAcc(){
        this.handleValidate();
        if(this.isValid && this.validCedNumb){
            solicitarPresupuestoWithoutAcc({
                oppMap : this.opportunityRecord,
                numCed : this.cedNum,
                cedProf : this.ProfSelected,
                items : this.itemsSelected
            }).then(result => {
                alert(result.Name + '\nEsta es la información de su presupuesto, cuando de click en OK esta ventana será cerrada y su información será procesada.');
                this.recordId = result.Id;
                this.uploadAttachment();
                window.close();
            })
            .catch(error => {
                console.log('Error ',error);
                alert(error.body.message);
            });
        }
    }

    handleValidate(){
        this.alertString ='';
        this.nullElements.length = 0;
        if(this.handleValidateElement(this.template.querySelectorAll('.validateOpp')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateOpp')));
        }
        if(this.ordenMed && this.handleValidateElement(this.template.querySelectorAll('.validateOrdeMed')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateOrdeMed')));
        }
        if(this.isProfessional && this.handleValidateElement(this.template.querySelectorAll('.validateProf')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateProf')));
        }
        if(this.isSolicitante && this.handleValidateElement(this.template.querySelectorAll('.validateCedSol')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateCedSol')));
        }
        if(!this.isSolicitante && this.handleValidateElement(this.template.querySelectorAll('.validateNewSol')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateNewSol')));
        }
        if(!this.isSolicitante && this.needsId && this.handleValidateElement(this.template.querySelectorAll('.validateCedNewSol')).length != 0){
            this.nullElements.push(this.handleValidateElement(this.template.querySelectorAll('.validateCedNewSol')));
        }
        if(this.itemsSelected.length == 0 || this.itemsSelected == null || this.itemsSelected === undefined){
            this.alertString = 'Por favor llena: Seleccionar Servicios';
            alert(this.alertString);
        }else if(this.nullElements.length != 0 ){
            this.alertString = 'Por favor llena los campos requeridos';
            alert(this.alertString);
        }else if(!this.validCedNumb && this.isSolicitante){
            this.alertString = 'Por favor ingresa un Numero de Documento valido';
            alert(this.alertString);
        }else{
            this.isValid = true;
        }
    }

    handleValidateElement(inputFields){
        this.nullElementValues.length = 0;
        inputFields.forEach(inputField => {
            if(inputField.value == null || typeof inputField.value === undefined || inputField.value.toString() == ''){
                inputField.reportValidity();
                this.isValid = false;
                this.nullElementValues.push(inputField.title);
            }
        });
        return this.nullElementValues;
    }

    handleLookupSearchProfesional(event) {
        const lookupElement = event.target;
        getProfesional({            
            searchTerm : event.detail.searchTerm
        })
        .then((results) => {
            debugger
            lookupElement.setSearchResults(results);
        })
        .catch((error) => {
            debugger
            console.log('Lookup error',error);
            console.error('Lookup error', JSON.stringify(error));
        });
    }

    /**
     * Handles the lookup search event.
     * Calls the server to perform the search and returns the resuls to the lookup.
     * @param {event} event `search` event emmitted by the lookup
     */
    handleLookupSearch(event) {
        const lookupElement = event.target;
        getDataLookup({
            searchTerm : event.detail.searchTerm, 
            selectedIds : event.detail.selectedIds,
            tipoDeDoc : this.accountRecord.Tipo_de_ID__c.toString()
        })
        .then((results) => {
            lookupElement.setSearchResults(results);
        })
        .catch((error) => {
            console.error('Lookup error', JSON.stringify(error));
        });
    }

    /**
     * Handles the lookup selection change
     * @param {event} event `selectionchange` event emmitted by the lookup.
     * The event contains the list of selected ids.
     */
    handleLookupSelectionChange(event) {
        this.itemsSelected = [];
        this.itemsSelected = event.detail;
    }
    handleLookupSelectionChangeProf(event) {
        this.ProfSelected = [];
        this.ProfSelected = event.detail;
    }

    //JHVV
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'recordId': this.recordId
            }
            console.log('this.fileData: ' +this.fileData);
        }
        reader.readAsDataURL(file);
    }

    uploadAttachment(){
        console.log('-----');
        console.log('recordId: ' + this.recordId);
        console.log('this.fileData: ' + this.fileData);
        if(this.fileData == null){
            console.log('file data null');
        }else{
            console.log('this.fileData.filename: ' + this.fileData.filename);
            console.log('this.fileData.recordId: ' + this.fileData.recordId);
            this.fileData.recordId = this.recordId;
            console.log('this.fileData.recordId: ' + this.fileData.recordId);
            
            const {base64, filename, recordId} = this.fileData;
            uploadFile({ base64, filename, recordId })
            .then(result=>{
                console.log('result: '+result);
                this.fileData = null;
                let title = `${filename} uploaded successfully!!`;
                console.log('title: '+title);
            }).catch(error => {
                console.log('Error upload: ',error);
            });
        }
        
    }
    
    clearfiledata(){
        this.fileData = null;       
    }
}