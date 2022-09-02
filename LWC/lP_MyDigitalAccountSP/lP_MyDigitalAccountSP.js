/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 05/07/2021
Description : My Digital Account JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
Lucas Agustin Lemes LAL
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 LAL 05/07/2021 initial version
********************************************************************************/
import { LightningElement, api, track } from 'lwc';
import LP_TarjetaChip from '@salesforce/resourceUrl/LP_TarjetaChipSP'
import LP_TarjetaDigitalLogoSP from '@salesforce/resourceUrl/LP_TarjetaDigitalLogoSP'
import LP_LogoVisaSP from '@salesforce/resourceUrl/LP_LogoVisaSP'
import getMyCardData from  '@salesforce/apex/LP_MyDigitalCardController.getMyCardData'
import LP_EyesSP from '@salesforce/resourceUrl/LP_EyesSP'
import LP_MiTarjetaDigitalMC from '@salesforce/label/c.LP_MiTarjetaDigitalMC'
import LP_SeOcultaraMC from '@salesforce/label/c.LP_SeOcultaraMC'
import LP_OcultarDatosMC from '@salesforce/label/c.LP_OcultarDatosMC'
import LP_MostrarDatosMC from '@salesforce/label/c.LP_MostrarDatosMC'
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_MyDigitalAccountSP extends LightningElement {


    @api showComponent=false;
    @api isMobile = FORM_FACTOR === 'Small';

    iconTarjeta ={
        LP_TarjetaChip,
        LP_TarjetaDigitalLogoSP,
        LP_LogoVisaSP,
        LP_EyesSP,
        LP_MiTarjetaDigitalMC,
        LP_SeOcultaraMC,
        LP_OcultarDatosMC,
        LP_MostrarDatosMC
    }

    connectedCallback(){

        this.mets();

    

    }

    async mets(){


        this.setBackground().then(() =>
        getMyCardData()
        .then( result => {
            this.message=result;
            if(result.loginOK==true){
                this.isError=false;
                this.name = result.name;
                this.code = result.codTar;
                this.vencimiento = result.fechaVencTarjeta;
                
                this.pan = result.tarjetaEmitidaPan;
                var pan2 = this.pan.slice(0,4) + " " + this.pan.slice(4,8) + " " + this.pan.slice(8,12) + " " + this.pan.slice(12,16) + " ";
                this.pan = pan2;
               
                this.showComponent=true;
            }
            else{
                this.isError=true;
                this.showComponent=false;
            }
                this.errors=result.message;
               
        }).catch(err => this.error(err)));
        

    }

    setBackground = () => new Promise(resolve => resolve("success"));

    @api showTimer = false;
    @track time = 60;
    @api timer;
    @api name;
    @api code1;
    @api code2;
    @api vencimiento;
    @api pan;

    startCountdown(){

        this.showTimer = true;
        this.timer = setInterval(function(){
             this.time = this.time - 1;
             if(this.time <= 0){
                 this.stopCountdown();
             }
            }.bind(this), 1000);
    }

    stopCountdown(){
        this.time = 60;
        clearInterval(this.timer);
        this.showTimer=false;
    }


}