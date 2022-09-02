/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Login Validation JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
Lucas Agustin Lemes LAL
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 14/06/2021 initial version
********************************************************************************/
 
import { LightningElement,api} from 'lwc';
import textErrorCuenta from '@salesforce/label/c.LP_MsjNoEcuentraRegistroRC'
import { NavigationMixin } from 'lightning/navigation';
import loginValidation from '@salesforce/apex/LP_LoginController.loginValidation'; 
import blockAccount from '@salesforce/apex/LP_LoginController.blockAccount'; 
import LP_LoginSP from '@salesforce/resourceUrl/LP_LoginSP'
import LP_Flecha from '@salesforce/resourceUrl/LP_Flecha'
import LP_TarjetasSP from '@salesforce/resourceUrl/LP_TarjetasSP'
import LP_IngresaTuCuentaLogin from '@salesforce/label/c.LP_IngresaTuCuentaLogin'
import LP_CrearCuentaLogin from '@salesforce/label/c.LP_CrearCuentaLogin'
import LP_RecuperarClaveLogin from '@salesforce/label/c.LP_RecuperarClaveLogin'
import LP_BtnRecordarLogin from '@salesforce/label/c.LP_BtnRecordarLogin'
import LP_BtnIngresarLogin from '@salesforce/label/c.LP_BtnIngresarLogin'
import LP_RutLogin from '@salesforce/label/c.LP_RutLogin'
import LP_MsjCuentaBloqueadaRC from '@salesforce/label/c.LP_MsjCuentaBloqueadaRC'
import LP_ClaveLogin from '@salesforce/label/c.LP_ClaveLogin'
import FORM_FACTOR from '@salesforce/client/formFactor';
export default class LP_LoginFormSP extends NavigationMixin(LightningElement) {
 
    @api message;
    @api showComponent= false;
    @api isMobile = FORM_FACTOR === 'Small';
    @api rut= '';
    checkboxVal = false;
    @api password='';
    @api blockAttempts = 6;
    @api rutCache='';
    @api errors;
    @api showMessageAccount = false;
    @api showLoginBox;
    showLoginBox=true;
    @api showRecoveryPassword= false;
    @api showCreateAccount=false;
    @api credentialsBool=false;
    @api logInData;
    @api isError=false;
    @api texto = textErrorCuenta;

    loginImages={LP_LoginSP};
    
    @api validationRule='([0-9]{7}|[0-9]{8})-([0-9]{1}|k)';

    isUsernamePasswordEnabled = true;
    showError = false;
    @api errorMessage = "Error, Sitio Privado";

    connectedCallback(){
        this.showComponent = true;
        this.getCredentials();
    }
    iconLog = {
        LP_IngresaTuCuentaLogin,
        LP_CrearCuentaLogin,
        LP_RecuperarClaveLogin,
        LP_BtnRecordarLogin,
        LP_BtnIngresarLogin,
        LP_RutLogin,
        LP_ClaveLogin,
        LP_MsjCuentaBloqueadaRC
    }

    get backgroundStyle() {
        return `background-image:url(${LP_LoginSP});
        background-repeat: no-repeat;
        background-size: 100% 112%;
        background-position-y: center;
        background-position-x: center;
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: flex-end;
        padding: 5% 12% 10%;`;
    }

    get blackarrowStyle() {
        return `background:url(${LP_Flecha}) no-repeat;
        padding: 8px 17px;`;
    }

    get tarjetasStyle() {
        return `background: url(${LP_TarjetasSP}) center 1em/90px no-repeat;
        font-size: 1.375em;
        font-weight: 300;
        font-family: 'Nunito', sans-serif;
        color: #363636;
        text-align: center;
        margin: 0px 33px 0px 33px;
        padding: 9em 42px 0px;`;
    }

    handleRut(event){
        this.rut = event.target.value;
     }
    
     handlePassword(event){
        this.password = event.target.value;
        window.addEventListener('paste',this.handlePasteEvent);
    } 

    handleClick(event) {
       window.addEventListener('paste',this.handlePasteEvent);
   }

   handlePasteEvent(event){
       event.preventDefault();
   }

     handleCheckBox(){
         if (this.checkboxVal == false){
            this.checkboxVal = true;
         }
         else{
             this.checkboxVal = false;
         }
     }

    validateLoginSP() {

        this.showComponent = false;
        this.isError = false;
        this.showMessageAccount = false;
       
            loginValidation({ rutdv: this.rut,password:this.password})
                .then( result => {

                    console.log("el RESULT da: " + JSON.stringify(result));


                    this.message=result;
                    if(result.loginOK==true){
                        this.isError=false;
                        this.rutCache='';
                        this.navigateToHomePage();
                    }
                    else{
                        this.isError=true;
                        this.showComponent = true;
                        if(result.message=="Según nuestros registros no tienes una cuenta creada en este sitio. Ingresa a Crear Cuenta"){
                            this.showMessageAccount = true;
                            this.isError=false;
                        }
                    }
                        this.errors=result.message;
                        if(this.checkboxVal==true){
                            this.saveCredentials();
                        }
                       

                        
                })
                .catch(error => {
                    
                    console.log("el ERROR da: " + JSON.stringify(error));
                 
                    var lenght = (error.body.message.split("cause")[1].split(":")[1].split("}")[0].length)-1
                    var string = error.body.message.split("cause")[1].split(":")[1].split("}")[0].substring(1,lenght);
                    this.isError=true;
                    if(string == "Password bloqueada" || error.body.message.search("line 147")>=0){
                        
                        this.errors = this.iconLog.LP_MsjCuentaBloqueadaRC;
                        
                    }else{
                        
                        var lenght = (error.body.message.split("cause")[1].split(":")[1].split("}")[0].length)-1
                        var string = error.body.message.split("cause")[1].split(":")[1].split("}")[0].substring(1,lenght);
                        this.errors = string;
                    }
                                     
                    this.showComponent = true;
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
        window.open(this.message.URL, '_self');
    }

}