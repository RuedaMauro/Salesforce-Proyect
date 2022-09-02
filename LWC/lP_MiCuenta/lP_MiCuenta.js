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
1.0 GLB 29/06/2021 initial version
********************************************************************************/
import { LightningElement, api } from 'lwc';
import tarjetaRoja from '@salesforce/resourceUrl/LP_TCreditoRojaSP';
import tarjetaNegra from '@salesforce/resourceUrl/LP_TCreditoNegraSP';
import getCreditClientData from '@salesforce/apex/LP_PaymentController.getCreditClientData'; 
import getBalanceData from '@salesforce/apex/LP_PaymentController.getBalanceData'; 
import getDebtPayment from '@salesforce/apex/LP_PaymentController.getDebtData'; 
import FORM_FACTOR from '@salesforce/client/formFactor';
export default class LP_MiCuenta extends LightningElement {

    @api name= '';
    @api lastName='';
    @api choppedCardNumber;
    @api usedAmount;
    @api availableAmount;
    @api isError;
    @api errors;
    @api imgTarjeta=tarjetaRoja;
    @api isMobile = FORM_FACTOR === 'Small';

    connectedCallback(){

        this.mets(); 
        
    }

    async mets(){



        this.setBackground().then(() =>
        getCreditClientData()
        .then( result => {
        

            if (result.tarjetaCod == 'VISA') // getCreditClientData
                this.imgTarjeta = tarjetaNegra;
            else
                this.imgTarjeta = tarjetaRoja;

            this.choppedCardNumber = result.tarjetaEmitidaPan.slice(-4); // getCreditClientData
            this.name=result.name;
            this.lastName=result.last_Name_1;
            
        }).catch(err => this.error(err)));


        this.setBackground().then(() =>
        getBalanceData()
        .then( result => {
        

            this.usedAmount = new Intl.NumberFormat('de-DE').format(result.utilcompra); // getBalanceData
            this.availableAmount =  new Intl.NumberFormat('de-DE').format(result.dispcompra); // getBalanceData
           
            
        }).catch(err => this.error(err)));


        this.setBackground().then(() =>
        getDebtPayment()
        .then( result => {
        

            var a= parseInt(result.facturada); // getDebtPayment
            this.debtBilled=new Intl.NumberFormat('de-DE').format(a);


        }).catch(err => this.error(err)));


    }

    setBackground = () => new Promise(resolve => resolve("success"));
}