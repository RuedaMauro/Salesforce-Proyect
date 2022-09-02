/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 21/07/2021
Description : Payment Layout Layout JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 21/07/2021 initial version
********************************************************************************/

import {LightningElement,api} from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';
import paymentSP from '@salesforce/resourceUrl/LP_PaymentsSP';
import cuposSP from '@salesforce/resourceUrl/LP_MisCuposSP';
import cuposSP2 from '@salesforce/resourceUrl/LP_HistoricalPaymentsSP';
import flechaSP from '@salesforce/resourceUrl/LP_FlechaItemsSP';
import LP_PagosPC from '@salesforce/label/c.LP_PagosPC'
import LP_PagarTuCuotaPC from '@salesforce/label/c.LP_PagarTuCuotaPC'
import LP_HistorialPagosPC from '@salesforce/label/c.LP_HistorialPagosPC'
import LP_RefinanciamientoPC from '@salesforce/label/c.LP_RefinanciamientoPC'
import LP_NecesitasRefinanciarPC from '@salesforce/label/c.LP_NecesitasRefinanciarPC'
import LP_PagosMensualesPC from '@salesforce/label/c.LP_PagosMensualesPC'
import getData from '@salesforce/apex/LP_PaymentController.getRefinanciationData';

export default class LP_PaymentLayout extends LightningElement {
    showPay = true;
    showPaymentHistory = false;
    showRefinantiation = false;
    showRefButton = false;
    @api quota = cuposSP;
    @api quota2 = cuposSP2;
    @api payment = paymentSP;
    @api arrow=flechaSP;
    @api isMobile = FORM_FACTOR === 'Small';

    iconR = {
        LP_PagosPC,
        LP_PagarTuCuotaPC,
        LP_HistorialPagosPC,
        LP_RefinanciamientoPC,
        LP_NecesitasRefinanciarPC,
        LP_PagosMensualesPC

    }
    connectedCallback() {
        var query = window.location.search.substring(1);
            var vars = query;
            var pair = vars.split("=");
            if(pair[1]=='paga-tu-cuota') this.changeShowPay();
            if(pair[1]=='historial-de-pagos') this.changeShowPaymentHistory();
            if(pair[1]=='refinanciamiento') this.changeShowRefinantiation();

        /**
        * @Description: Shows or hides the refinantiation button.
        * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
        * @Date: 21/07/2021
        */

        getData()
            .then((result) => {

                if (result.renegSituation == true) {
                    this.showRefButton = true;
                }

            })
           
    }

    changeShowPay() {
        this.showPay = true;
        this.showPaymentHistory = false;
        this.showRefinantiation = false;
    }

    changeShowPaymentHistory() {
        this.showPay = false;
        this.showPaymentHistory = true;
        this.showRefinantiation = false;
    }

    changeShowRefinantiation() {
        this.showPay = false;
        this.showPaymentHistory = false;
        this.showRefinantiation = true;
    }
}