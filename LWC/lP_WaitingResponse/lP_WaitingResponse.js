/******************************************************************************
Project      : La Polar Salesforce Onboarding 
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Javascript - Waiting Response
History      : PCRM-17
**************************ACRONYM OF AUTHORS************************************
AUTHOR                      ACRONYM
Nelson Lepiqueo L.            NLL
********************************************************************************
VERSION  AUTHOR         DATE            Description
1.0       NLL	     08/06/2021		  initial version
********************************************************************************/
import { LightningElement, track, api} from 'lwc';
import customerAzurianConsult from '@salesforce/apex/LP_OnboardingStepThreeController.customerAzurianConsult';
import getStaticResource from '@salesforce/apex/LP_OnboardingStepFourController.getStaticResource';
import getExtensionMult from '@salesforce/apex/LP_OnboardingStepFourController.extStaticResource';
import customerIdentCheck from '@salesforce/apex/LP_OnboardingStepThreeController.customerIdentCheck';
import validateClientBeClever from '@salesforce/apex/LP_OnboardingStepFourController.validateClientBeClever';
import txtTitleStepFourMobile from '@salesforce/label/c.LP_TitleStepFourMobile';

//Import Static Resource
import resourceWait from '@salesforce/resourceUrl/LP_WaitingResponse';
import resourceWaitMov from '@salesforce/resourceUrl/LP_WaitingResponseMov';
//Import Custom Label
import msgText from '@salesforce/label/c.LP_WaitingResponseText';
import lBtnNext from '@salesforce/label/c.LP_Continuar';

export default class LP_WaitingResponse extends LightningElement {
    @track resource = {
        resourceWait,
        resourceWaitMov
    }
    @track labels = {
        button : {
            next : lBtnNext
        },
        text : {
            msgText : msgText,
            titleMobile: txtTitleStepFourMobile
        }
    }
    @track objLead = { 'sobjectType': 'Lead' };
    @api objLeadIn = { 'sobjectType': 'Lead' };
    @api azurianResponse = '';
    @api transRef;
    @api sppin = false;
    @api disabledButton = false;
    // 5000 milliseconds = 5 seconds. 
    @track progress = 15000; 
    @api interval;
    @api extension = '';
    @api extValImg = false;
    @api extvalVid = false;
    @track exImg;
    @track exVideo;
    @api valService = 'nOk';
    
    /**
    *  @Description: Method that get the extension static resource
    *  @Autor:       Nelson Lepiqueo, Deloitte.
    *  @Date:        08/06/2021
    */
    getExtension(){
        getExtensionMult()
        .then(result => {
            this.exImg = JSON.parse(JSON.stringify(result.objImgList));
            this.exVideo = JSON.parse(JSON.stringify(result.objVideoList));
        })
        .catch(error => {
            window.console.log('error => '+JSON.stringify(error));
        });
    }

    /**
    *  @Description: Method that get the status azurian response
    *  @Autor:       Nelson Lepiqueo, Deloitte.
    *  @Date:        08/06/2021
    */
     getMultimedia(event){

        this.getExtension();
        const nameStaticRes = 'LP_WaitingResponse';
                
        getStaticResource({nameStatic: nameStaticRes})
        .then(result => {
            this.extension = JSON.parse(JSON.stringify(result));
            this.extValImg = false;
            this.extValVid = false;

            this.exImg.forEach(element => {
                if (!this.extValImg){
                    this.extValImg = (this.extension == element) ? true : false;
                }
            });
            this.exVideo.forEach(element => {
                if (!this.extValVid){
                    this.extValVid = (this.extension == element) ? true : false;
                }
            });          
        })
        
        .catch(error => {
            window.console.log('error => '+JSON.stringify(error));
        });
    }

    /**
    *  @Description: Method that get the status azurian response
    *  @Autor:       Nelson Lepiqueo, Deloitte.
    *  @Date:        08/06/2021
    */
    async getAzurianConsult(event){
        try{
            const result1 = await customerAzurianConsult({record: this.objLead, transRef: this.transRef, url:this.sfdcBaseURL});
            if(result1 == 'DONE'){

                const result2 = await customerIdentCheck({record: this.objLead, transRef: this.transRef});
                this.sfdcBaseURL = window.location.origin;
                const result3 = await validateClientBeClever({record: this.objLead, transRef: this.transRef, url:this.sfdcBaseURL});
                    
                this.sppin = true;
                this.disabledButton = false;
                this.valService = 'ok';
                this.stopInterval();
  
            }
            
        } catch (error) {
            this.error = error;
            var message = JSON.parse(error.body.message);
            this.valService = message.cause;
            this.stopInterval();
            this.submitData(event);
        } 

    }
    
    /**
    *  @Description: renderedCallback
    *  @Autor:       Nelson Lepiqueo, Deloitte
    *  @Date:        22/06/2021
    */
     renderedCallback(event){

        this.getMultimedia(event);       
    }

    /**
    *  @Description: Method init connectedCallback
    *  @Autor:       Nelson Lepiqueo, Deloitte
    *  @Date:        10/06/2021
    */
    connectedCallback(event){

        this.objLead.FirstName = this.objLeadIn.FirstName == undefined ? '' : this.objLeadIn.FirstName;
        this.objLead.LastName = this.objLeadIn.LastName == undefined ? '' : this.objLeadIn.LastName;
        this.objLead.LP_ApellidoMaterno__c = this.objLeadIn.LP_ApellidoMaterno__c == undefined ? '' : this.objLeadIn.LP_ApellidoMaterno__c;
        this.objLead.LP_Rut__c = this.objLeadIn.LP_Rut__c == undefined ? '' : this.objLeadIn.LP_Rut__c;

        this.objLead.LP_Nacionalidad__c = this.objLeadIn.LP_Nacionalidad__c == undefined ? '' : this.objLeadIn.LP_Nacionalidad__c;
        this.objLead.LP_Genero__c = this.objLeadIn.LP_Genero__c == undefined ? '' : this.objLeadIn.LP_Genero__c;
        this.objLead.Email = this.objLeadIn.Email == undefined ? '' : this.objLeadIn.Email;
        this.objLead.MobilePhone = this.objLeadIn.MobilePhone == undefined ? '' : this.objLeadIn.MobilePhone;
        this.objLead.LP_FechaPago__c = this.objLeadIn.LP_FechaPago__c == undefined ? '' : this.objLeadIn.LP_FechaPago__c;
        this.objLead.LP_Ocupacion__c = this.objLeadIn.LP_Ocupacion__c == undefined ? '' : this.objLeadIn.LP_Ocupacion__c;
        this.objLead.LP_NivelEducacional__c = this.objLeadIn.LP_NivelEducacional__c == undefined ? '' : this.objLeadIn.LP_NivelEducacional__c;
        this.objLead.Street  = this.objLeadIn.Street == undefined ? '' : this.objLeadIn.Street;
        this.objLead.City = this.objLeadIn.City == undefined ? '' : this.objLeadIn.City;
        this.objLead.State = this.objLeadIn.State == undefined ? '' : this.objLeadIn.State;
        this.objLead.Country = this.objLeadIn.Country == undefined ? '' : this.objLeadIn.Country;

        this.disabledButton = true;

        const done = 'DONE';
        if (this.disabledButton && !this.azurianResponse.match(done)){ 
            this.interval = setInterval( () => {  
            this.progress = this.progress + 15000;  
            this.getAzurianConsult(event);
            }, this.progress);
        }
    }
     
    /**
    *  @Description: Stop interval
    *  @Autor:       Nelson Lepiqueo, Deloitte
    *  @Date:        11/06/2021
    */
    stopInterval() {
        clearInterval(this.interval);
    }
    /**
    *  @Description: Go to next step
    *  @Autor:       Nelson Lepiqueo, Deloitte
    *  @Date:        10/06/2021
    */
    submitData(event) {

        const pathEvent = new CustomEvent('setnextstep', {detail: this.valService});
        this.dispatchEvent(pathEvent);
    }
}