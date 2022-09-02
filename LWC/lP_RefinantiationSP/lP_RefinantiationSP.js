/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Account Creation JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
Lucas Agustin Lemes LAL
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 21/07/2021 initial version
********************************************************************************/
import {
    LightningElement,
    api
} from 'lwc';
import LP_TasasInteresRefinanciamiento from '@salesforce/label/c.LP_TasasInteresRefinanciamiento';
import getAmountInfo from '@salesforce/apex/LP_PaymentController.getPreSimulationData';
import getCuotaInfo from '@salesforce/apex/LP_PaymentController.getSimulationData';
import LP_RefinanciamientoPC from '@salesforce/label/c.LP_RefinanciamientoPC'
import LP_DatosSimulacionPC from '@salesforce/label/c.LP_DatosSimulacionPC'
import LP_MontosRefinanciarPC from '@salesforce/label/c.LP_MontosRefinanciarPC'
import LP_MsjRefinanciamientoPC from '@salesforce/label/c.LP_MsjRefinanciamientoPC'
import LP_DescargarTasasInteresRef from '@salesforce/label/c.LP_DescargarTasasInteresRef'
import LP_BtnSimularPC from '@salesforce/label/c.LP_BtnSimularPC'
import LP_BtnVolverSimularPC from '@salesforce/label/c.LP_BtnVolverSimularPC'
import LP_RefinancingSP from '@salesforce/resourceUrl/LP_RefinancingSP';
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_RefinantiationSP extends LightningElement {

    @api opacityStep1 = false;
    @api opacityStep2 = false;
    @api montoAFinanciar = 0;
    @api cuotaMin = 0;
    @api cuotaMax = 0;
    @api isMobile = FORM_FACTOR === 'Small';
    @api result;
    @api montoCuota;
    @api isError;
    @api errors;
    @api ctc;
    @api resultAMandar = {
        "deudaavance":"",
        "deudaavancexl" :"",
        "deudacompra" :"",
        "deudatotal_r" :"",
        "dias_mora" :"",
        "rut" :"",
        "tasa" :"",
        "tipofac" :"",
        "tipofac3" :"",
        "dv":""
    }

    @api options1 = [];
    LP_TasasLink = LP_TasasInteresRefinanciamiento;

    iconRef = {
        LP_RefinanciamientoPC,
        LP_DatosSimulacionPC,
        LP_MontosRefinanciarPC,
        LP_MsjRefinanciamientoPC,
        LP_DescargarTasasInteresRef,
        LP_BtnVolverSimularPC,
        LP_BtnSimularPC,
        LP_RefinancingSP

    }

    get options() {
        return this.options1;

    }

    connectedCallback() {
      
      /**
      * @Description: Gets pre simulated data.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */

        getAmountInfo()
            .then(result => {

                if (result.loginOK) {
                    this.result = result;
                    var options1 = [];
                    this.cuotaMax = result.cuotamax;
                    this.cuotaMin = result.cuotamin;
                    this.montoAFinanciar = "$" + new Intl.NumberFormat('de-DE').format(result.deudatotal_r);
                    this.resultAMandar.deudaavance = result.deudaavance;
                    this.resultAMandar.deudaavancexl = result.deudaavancexl;
                    this.resultAMandar.deudacompra = result.deudacompra;
                    this.resultAMandar.deudatotal_r = (result.deudatotal_r).toString();
                    this.resultAMandar.dias_mora = result.dias_mora;
                    this.resultAMandar.rut = (result.rut).toString();
                    this.resultAMandar.tasa = result.tasa;
                    this.resultAMandar.tipofac = result.tipofac;
                    this.resultAMandar.tipofac3 = result.tipofac3;
                    this.resultAMandar.dv= result.dv;
                    console.log(this.resultAMandar);
                    for (let i = this.cuotaMin; i <= this.cuotaMax; i++) {

                        var data = [];

                        data = {

                            label: i.toString(),
                            value: i.toString()
                        };

                        options1.push(data);

                    }
                    this.options1 = options1;

                }



            })


    }


    @api value = this.cuotaMin;

    handleChange(event) {
        this.value = event.detail.value;
    }

    simulate() {

        if(this.value != "undefined"){

      /**
      * @Description: Gets simulated data.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */

            getCuotaInfo({  
                rpm: this.resultAMandar,
                cuotas: this.value
            })
            .then(result => {
        
                if (result.loginOK==true) {
                    
                    this.ctc = new Intl.NumberFormat('de-DE').format(result.imptotalL1);
                    this.montoCuota =new Intl.NumberFormat('de-DE').format(result.impcuotaL1);
                    this.opacityStep1 = true;
                    this.opacityStep2 = true;

                }

            })

        }
        else{
            this.isError = true;
            this.errors = "Debes elegir una cuota";
        }
        
    }

    simulateAgain() {

        this.opacityStep1 = false;
        this.opacityStep2 = false;

    }


}