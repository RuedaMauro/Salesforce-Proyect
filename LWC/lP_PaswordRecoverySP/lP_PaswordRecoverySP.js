/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Password Recovery JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 14/06/2021 initial version
********************************************************************************/

import { LightningElement,api } from 'lwc';
import ValidateAccount from '@salesforce/apex/LP_ForgotPassword.ValidateAccount'; 
import forgotPassword from '@salesforce/apex/LP_ForgotPassword.forgotPassword'; 
import resendOTP from '@salesforce/apex/LP_ForgotPassword.ResendOTP';
import LP_Flecha from '@salesforce/resourceUrl/LP_Flecha'
import LP_TarjetasSP from '@salesforce/resourceUrl/LP_TarjetasSP'
import unblockAccount from '@salesforce/apex/LP_ForgotPassword.unblockAccount'; 
import LP_RecuperarClaveRC from '@salesforce/label/c.LP_RecuperarClaveRC'
import LP_MsjRecuperarTuClaveRC from '@salesforce/label/c.LP_MsjRecuperarTuClaveRC'
import LP_EnviarCodigoOTP from '@salesforce/label/c.LP_EnviarCodigoOTP'
import LP_MsjEnviarCodigoOTP from '@salesforce/label/c.LP_MsjEnviarCodigoOTP'
import LP_BtnSiguienteRC from '@salesforce/label/c.LP_BtnSiguienteRC'
import LP_BtnReenviarCodigoRC from '@salesforce/label/c.LP_BtnReenviarCodigoRC'
import LP_BtnValidarRC from '@salesforce/label/c.LP_BtnValidarRC'
import LP_CodigoIncorrectoRC from '@salesforce/label/c.LP_CodigoIncorrectoRC'
import LP_ContrasenasNoCoincidenRC from '@salesforce/label/c.LP_ContrasenasNoCoincidenRC'
import LP_MsjSinIntentosOtpRC from '@salesforce/label/c.LP_MsjSinIntentosOtpRC'
import LP_CreaNuevaClaveRC from '@salesforce/label/c.LP_CreaNuevaClaveRC'
import LP_BtnFinalizarCC from '@salesforce/label/c.LP_BtnFinalizarCC'
import LP_ContrasenaCambiadaRC from '@salesforce/label/c.LP_ContrasenaCambiadaRC'
import LP_ValidaciondeClaveRC from '@salesforce/label/c.LP_ValidaciondeClaveRC'
import LP_BtnCambiarContrasenaRC from '@salesforce/label/c.LP_BtnCambiarContrasenaRC'
import LP_MsjCuentaBloqueadaRC from '@salesforce/label/c.LP_MsjCuentaBloqueadaRC'
import LP_MsjIntentosReenviarCod from '@salesforce/label/c.LP_MsjIntentosReenviarCod'
import LP_ContrasenaRC from '@salesforce/label/c.LP_ContrasenaRC'
import LP_ConfirmarContrasenaRC from '@salesforce/label/c.LP_ConfirmarContrasenaRC'

export default class LP_PaswordRecoverySP extends LightningElement {

    @api messegeGetCelphone;
    @api showhide1
    @api attempsEqualTo1 = false;
    showhide1=true;
    @api showhide2
    @api blockAttempts = 3;
    showhide2=false;
    @api showhide3
    showhide3=false;
    @api showhide4
    showhide4=false;
    @api rut= '';
    @api isValidRut = false;  
    @api celphone;
    @api OTP;
    @api isErrorBlocked = false;
    @api timeOut=false;
    attemps=3;
    @api password;
    @api duplicatePassword;
    @api errors;
    @api isError=false;
    @api numberChopped;

    @api validationRule='([0-9]{7}|[0-9]{8})-([0-9]{1}|k|K)';
    @api validationRulePassword='(([0-9]|([a-z]|[A-Z]))*[0-9]([0-9]|([a-z]|[A-Z]))*([a-z]|[A-Z])([0-9]|([a-z]|[A-Z]))*)|(([0-9]|([a-z]|[A-Z]))*([a-z]|[A-Z])([0-9]|([a-z]|[A-Z]))*[0-9]([0-9]|([a-z]|[A-Z]))*)';

    iconRC = {
        LP_RecuperarClaveRC,
        LP_MsjRecuperarTuClaveRC,
        LP_EnviarCodigoOTP,
        LP_MsjEnviarCodigoOTP,
        LP_BtnSiguienteRC,
        LP_BtnReenviarCodigoRC,
        LP_BtnValidarRC,
        LP_CreaNuevaClaveRC,
        LP_BtnFinalizarCC,
        LP_ContrasenaCambiadaRC,
        LP_ValidaciondeClaveRC,
        LP_BtnCambiarContrasenaRC,
        LP_MsjIntentosReenviarCod,
        LP_MsjCuentaBloqueadaRC,
        LP_ContrasenaRC,
        LP_ConfirmarContrasenaRC
    }

    handleRut(event){
        let inputCmp = event.target;
        this.rut = inputCmp.value;
        this.isValidRut = inputCmp.checkValidity();
        this.isError=false;
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

     handleDuplicatePassword(event){
        this.duplicatePassword = event.target.value;
        this.isError=false;
        window.addEventListener('paste',this.handlePasteEvent);
     }
    

     get blackarrowStyle() {
        return `background:url(${LP_Flecha}) no-repeat;
        padding: 8px 17px;
        margin: 10px 10px 10px 10px;`;
    }

    get blackarrowStyle2() {
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
        margin: 0;
        padding: 9em 42px 0px;`;
    }

     handleOTP(event){
        this.inputOTP = event.target.value;
        this.isError=false;
     }

     setTimer(){
       this.timeOut=false;
      }
      
            /**
            * @Description: Validates that the RUT is valid and exists in the databe of La Polar. It also sends the OTP Message the first time.
            * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
            * @Date: 14/07/2021
            */

    validateRut() {
        if(this.isValidRut) {       // el boton solo ejecuta si el RUT es valido
            ValidateAccount({ rutdv: this.rut })
            .then((result) => {
                if(result.loginOK==true){
                    this.isError=false;
                    this.attemps=3;
                    this.messegeGetCelphone=result;
                    this.celphone=result.no_movil;
                    this.numberChopped = this.celphone.slice(4,8);
                    this.OTP=result.code;
                    setTimeout(function(){
                        this.OTP = ""
                    }.bind(this),300000);
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
                    this.handleClose()
                }.bind(this),3000);

            }
        
     }
    

    /**
    * @Description: Validates if the OTP already saved in JS matches the one entered by the user . 
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */


    validateOTP() {
        
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
    * @Description: Changes the password for the user. 
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 14/06/2021
    */

    generateNewPassword() {
        if(this.password==this.duplicatePassword){
        forgotPassword({ rutdv: this.rut, password:this.password })
            .then((result) => {
                if(result.loginOK==true){
                    unblockAccount({ rutdv: this.rut})
                    .then((result) => {
                        this.siguiente3();          
                    })
                    
                    
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
                    this.errors = "Error en la recuperación de contraseña, por favor intenta mas tarde"
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

    handleClose() {

        
        this.dispatchEvent(new CustomEvent('close'));
        
    }

    
    
}