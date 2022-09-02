/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Login Validation JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 14/06/2021 initial version
********************************************************************************/
 
import { LightningElement,api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import loginValidation from '@salesforce/apex/LP_LoginController.loginValidation'; 
import FORM_FACTOR from '@salesforce/client/formFactor';
export default class LP_LoginFormSP extends NavigationMixin(LightningElement) {
 
    @api message;
    @api isMobile = FORM_FACTOR === 'Small';
    @api rut= '';
    @api password='';
    @api errors;
    @api showLoginBox;
    showLoginBox=true;
    @api showRecoveryPassword= false;
    @api showCreateAccount=false;
    @api credentialsBool=false;
    @api logInData;
    @api isError=false;
    
    @api validationRule='([0-9]{7}|[0-9]{8})-([0-9]{1}|k)';

    isUsernamePasswordEnabled = true;
    showError = false;
    @api errorMessage = "Error, Sitio Privado";

    connectedCallback(){
        this.getCredentials();
    }

    handleRut(event){
        this.rut = event.target.value;
     }
    
     handlePassword(event){
        this.password = event.target.value;
     }
 
    validateLogin() {
        console.log(this.isMobile);
        loginValidation({ rutdv: this.rut,password:this.password})
            .then( result => {
                this.message=result;
                if(result.loginOK==true){
                    this.isError=false;
                    this.navigateToHomePage();
                }
                else{
                    this.isError=true;
                }
                    this.errors=result.message;
                    this.saveCredentials();
                    console.log(this.isError);
            })
            .catch(error => {
                console.log("El error : " + JSON.stringify(error));
                this.saveCredentials();
            });
    }
 
    changeRecoveryPassword(){
        this.showLoginBox=false;
        this.showRecoveryPassword=true;
        this.showCreateAccount=false;
    }
 
    changeCreateAccount(){
        this.showLoginBox=false;
        this.showRecoveryPassword=false;
        this.showCreateAccount=true; 
    }
 
    saveCredentials(){
        localStorage.setItem('rut', this.rut);
    }

    getCredentials(){
        var cred = localStorage.getItem('rut');
        if(cred!=null){
            this.rut=cred;
        }
    }
 
    crendentialsBoolSet(){
        this.credentialsBool=true;
    }

    returnToLogin(){
        this.showLoginBox=true;
        this.showRecoveryPassword=false;
        this.showCreateAccount=false;
      
    }
    navigateToHomePage() {
        console.log('navegar');
        // const config = {
        //     type: 'standard__webPage',
        //     attributes: {
        //         url: this.message.url,
        //     }
        // };
        // this[NavigationMixin.Navigate](config);
        window.open(this.message.URL, '_self');
        console.log('navFin');
    }

}