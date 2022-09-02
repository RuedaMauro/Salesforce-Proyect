/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Account Creation JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 14/06/2021 initial version
********************************************************************************/

import { LightningElement,api } from 'lwc';
import validateAccount from '@salesforce/apex/LP_CreateAccount.validateAccount'; 
import resendOTP from '@salesforce/apex/LP_CreateAccount.ResendOTP'; 
import createAccount from '@salesforce/apex/LP_CreateAccount.CreateAccount';
import LP_Flecha from '@salesforce/resourceUrl/LP_Flecha'
import LP_TarjetasSP from '@salesforce/resourceUrl/LP_TarjetasSP'
import LP_CreaTuCuentaCC from '@salesforce/label/c.LP_CreaTuCuentaCC'
import LP_MsjCreacionCuentaCC from '@salesforce/label/c.LP_MsjCreacionCuentaCC'
import LP_BtnIngresarCC from '@salesforce/label/c.LP_BtnIngresarCC'
import LP_BtnReenviarCodigoRC from '@salesforce/label/c.LP_BtnReenviarCodigoRC'
import LP_BtnValidarRC from '@salesforce/label/c.LP_BtnValidarRC'
import LP_CuentaCreadaCC from '@salesforce/label/c.LP_CuentaCreadaCC'
import LP_BtnFinalizarCC from '@salesforce/label/c.LP_BtnFinalizarCC' 
import LP_CodigoIncorrectoRC from '@salesforce/label/c.LP_CodigoIncorrectoRC'
import LP_ContrasenaRC from '@salesforce/label/c.LP_ContrasenaRC'
import LP_ConfirmarContrasenaRC from '@salesforce/label/c.LP_ConfirmarContrasenaRC'
import LP_ContrasenasNoCoincidenRC from '@salesforce/label/c.LP_ContrasenasNoCoincidenRC'
import LP_ValidaciondeClaveRC from '@salesforce/label/c.LP_ValidaciondeClaveRC'
import LP_MsjIntentosReenviarCod from '@salesforce/label/c.LP_MsjIntentosReenviarCod'
import LP_EnviarCodigoOTP from '@salesforce/label/c.LP_EnviarCodigoOTP'
import LP_MsjSinIntentosOtpRC from '@salesforce/label/c.LP_MsjSinIntentosOtpRC'
import LP_MsjEnviarCodigoOTP from '@salesforce/label/c.LP_MsjEnviarCodigoOTP'
import LP_BtnCrearCuentaCC from '@salesforce/label/c.LP_BtnCrearCuentaCC'
import textClave from '@salesforce/label/c.LP_ValidaciondeClaveRC';


export default class LP_CreateAccountSP extends LightningElement {

    @api messegeGetCelphone;
    @api rut= '';
    @api isValidRut = false;
    @api JSONCreate = {};
    showhide1=true;
    @api showhide2
    showhide2=false;
    @api showhide3
    showhide3=false;
    @api attempsEqualTo1 = false;
    @api celphone;
    @api blockAttempts = 3;
    @api name;
    @api lastName;
    @api lastName2;
    @api celphoneSliced;
    @api mail;
    @api mailSliced;
    @api OTP;
    @api OTPfield;
    @api textVal = textClave;
    timeOut=false;
    attemps=3;
    @api password;
    @api duplicatePassword;
    @api errors;
    @api validationRule='([0-9]{7}|[0-9]{8})-([0-9]{1}|k|K)';
    @api validationRulePassword='(([0-9]|([a-z]|[A-Z]))*[0-9]([0-9]|([a-z]|[A-Z]))*([a-z]|[A-Z])([0-9]|([a-z]|[A-Z]))*)|(([0-9]|([a-z]|[A-Z]))*([a-z]|[A-Z])([0-9]|([a-z]|[A-Z]))*[0-9]([0-9]|([a-z]|[A-Z]))*)';
    @api isError=false;
    @api numberChopped;
    @api rut1;
    @api dv;
   

    iconCC = {
        LP_CreaTuCuentaCC,
        LP_MsjCreacionCuentaCC,
        LP_BtnIngresarCC,
        LP_BtnReenviarCodigoRC,
        LP_BtnValidarRC,
        LP_CuentaCreadaCC,
        LP_BtnFinalizarCC,
        LP_ContrasenasNoCoincidenRC,
        LP_MsjIntentosReenviarCod,
        LP_EnviarCodigoOTP,
        LP_MsjEnviarCodigoOTP,
        LP_BtnCrearCuentaCC,
        LP_ContrasenaRC,
        LP_ConfirmarContrasenaRC
    }

    getRutValue(event){
        let inputCmp = event.target;
        this.rut = inputCmp.value;
        this.isValidRut = inputCmp.checkValidity();
        this.isError=false;
    }

    getOTPValue(event){
        this.OTPfield = event.target.value;
        this.isError=false;
    }

    handleOTP(event){
        this.inputOTP = event.target.value;
        this.isError=false;
   }

   get blackarrowStyle1() {
    return `background:url(${LP_Flecha}) no-repeat;
    padding: 8px 17px;
    margin: 10px 10px 10px -33px;`;
    }

    get blackarrowStyle2() {
        return `background:url(${LP_Flecha}) no-repeat;
        padding: 8px 17px;
        margin: 10px 10px 10px -20px;`;
    }

    get blackarrowStyle3() {
        return `background:url(${LP_Flecha}) no-repeat;
        padding: 9px 17px;
        margin: 10px 10px 10px -41px;`;
        }

    get tarjetasStyle() {
        return `background: url(${LP_TarjetasSP}) center 1em/90px no-repeat;
        font-size: 1.375em;
        font-weight: 300;
        font-family: 'Nunito', sans-serif;
        color: #363636;
        text-align: center;
        margin: 0;
        padding: 9em 42px 0px;`;
    }

    handleDuplicatePassword(event){
        this.duplicatePassword = event.target.value;
        this.isError=false;
        window.addEventListener('paste',this.handlePasteEvent);
    } 

    handlePassword(event){
        this.password = event.target.value;
        this.isError=false;
        window.addEventListener('paste',this.handlePasteEvent);
    } 

    handleClick(event) {
       window.addEventListener('paste',this.handlePasteEvent);
   }

   handlePasteEvent(event){
       event.preventDefault();
   }

    async setTimer(){
        this.timeOut=false;
       } 

    /**
    * @Description: Validates that the RUT is valid and exists in the databe of La Polar. It also sends the OTP Message the first time.
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */
   
    validateRut() {
        this.isError = false;
        if(this.isValidRut) {      
            validateAccount({ rutdv: this.rut })
            .then((result) => {
                this.attemps=3;
                if(result.loginOK==true){
                    this.isError=false;
                    this.celphone=result.no_movil;
                    this.celphoneSliced = this.celphone.slice(0,4) + "****";
                    this.name=result.name;
                    this.lastName=result.last_Name_1;
                    this.lastName2=result.last_Name_2;
                    this.mail=result.email
                    var mailChoped = result.email == " " ? this.mail.split("@") : "-";
                    this.mailSliced = mailChoped =="-" ? "-" : this.mail.slice(0,4) + "@" + mailChoped[1];
                    if(mailChoped=="-") this.mail="-";
                    this.OTP=result.code;
                    setTimeout(function(){
                        this.OTP = ""
                    }.bind(this),300000);
                    this.rut1=result.rut;
                    this.dv=result.dv;
                    this.attempsEqualTo1 = this.attemps == 1 ? true : false;
                    this.numberChopped= this.celphone.slice(4,8);
                    this.siguiente1();
                }
                else{
                    this.isError=true;
                    this.errors=result.message;
                }
            })
            .catch((error) => {
                this.isError = true;
                var lenght = (error.body.message.split("cause")[1].split(":")[1].split("}")[0].length)-1
                var string = error.body.message.split("cause")[1].split(":")[1].split("}")[0].substring(1,lenght);
                this.errors = string;
            }); 
        }
    }

    /**
    * @Description: Resends the OTP Message.
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */
    
    sendAgain() {
        this.isError = false;
            if(this.attemps>0){
         resendOTP({ rutdv: this.rut , no_movil: this.celphone })
             .then((result) => {
                 if(result.loginOK==true){
                     this.attemps=this.attemps-1;
                     this.timeOut=true;
                     this.isError=false;
                     this.OTP=result.code;
                     this.blockAttempts = 3;
                    setTimeout(function(){
                        this.OTP = ""
                    }.bind(this),300000);
                    }
                    else{
                        this.isError=true;
                        this.errors=result.message;
                 }
             })
             .catch((error) => {
                this.isError = true;
                var lenght = (error.body.message.split("cause")[1].split(":")[1].split("}")[0].length)-1
                var string = error.body.message.split("cause")[1].split(":")[1].split("}")[0].substring(1,lenght);
                this.errors = string;
                });
            }
            else{
                this.isError=true;
                this.errors='Ya superaste la cantidad de intentos validos';
                setTimeout(function(){
                    this.returnToLogin()
                }.bind(this),3000);

            }
        
     }
    
     /**
    * @Description: Validates if the OTP already saved in JS matches the one entered by the user . 
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */

     validateOTP() {
        this.isError = false;
        if(this.blockAttempts >1 ){
            if(this.OTP == this.inputOTP){
                this.siguiente2();
                this.blockAttempts = 3;
            }
            else{
                this.isError=true;
                this.blockAttempts = this.blockAttempts - 1;
                this.errors= LP_CodigoIncorrectoRC;
            }
    
        }
        else{
            this.isError=true;
            this.errors = LP_MsjSinIntentosOtpRC; 
            }
     }
     
    /**
    * @Description: Creates an account with the RUT of the user and the password it entered . 
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */

     createAccount() {
        this.isError = false;
         if(this.password==this.duplicatePassword){
             this.JSONCreate =
             {"last_Name_1":this.lastName,
                "last_Name_2":this.lastName2,
                "name":this.name,
                "no_movil":this.celphone.toString(),
                "email":this.mail,
                "rut":this.rut1.toString(),
                "dv":this.dv,
                "password":this.password}

                
                
         createAccount({params: this.JSONCreate})
             .then((result) => {
                 if(result.loginOK==true){
                     this.isError=false;
                     this.showhide3=false;
                     this.showhide4=true; 
                    }
                    else{
                        this.isError=true;
                        this.errors=result.message;
                 }
                 
             })
             .catch((error) => {
                this.isError = true;
                if(error.body.message.search("INVALID_NEW_PASSWORD")>=0){
                    
                    this.errors = "Debes ingresar una clave alfanumérica de 8 dígitos";
                }
                else{
                    this.errors = "Error en la creacion de contraseña, por favor intenta mas tarde"
                }
                
                 
             });
         }
         else{
            this.isError=true;
            this.errors= LP_ContrasenasNoCoincidenRC;
        }
         
 
     }
    siguiente1(){
        this.showhide1=false;
        this.showhide2=true;
    }
    siguiente2(){
        this.showhide2=false;
        this.showhide3=true;
    }
    siguiente3(){
        this.showhide3=false;
        this.showhide4=true;
    }

    return2(){
        this.showhide2=false;;
        this.showhide1=true;

    }
    return3(){
        this.showhide3=false;
        this.showhide2=true;

    }
    return4(){
        this.showhide4=false;
        this.showhide3=true;

    }
    returnToLogin(){
        this.dispatchEvent(new CustomEvent('close'));
    }
    
}