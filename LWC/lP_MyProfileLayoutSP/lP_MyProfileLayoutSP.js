/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 29/07/2021
Description : My Profile Layout JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
Lucas Agustin Lemes LAL
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 LAL 29/07/2021 initial version
********************************************************************************/

import { LightningElement, api } from 'lwc';
import paymentSP from '@salesforce/resourceUrl/LP_PaymentsSP';
import cuposSP from '@salesforce/resourceUrl/LP_MisCuposSP';
import LP_PerfilUsuarioBlackSP from '@salesforce/resourceUrl/LP_PerfilUsuarioBlackSP';
import cuposSP2 from '@salesforce/resourceUrl/LP_HistoricalPaymentsSP';
import flechaSP from '@salesforce/resourceUrl/LP_FlechaItemsSP';
import FORM_FACTOR from '@salesforce/client/formFactor';
import LP_MiPerfilMP from '@salesforce/label/c.LP_MiPerfilMP'
import LP_MiProfileMP from '@salesforce/label/c.LP_MiProfileMP'
import LP_MisDocumentosMP from '@salesforce/label/c.LP_MisDocumentosMP'


export default class LP_PaymentLayout extends LightningElement {
    showProfile=true;
    showMyDueDates=false;
    @api quota=cuposSP;
    @api arrow = flechaSP;
    @api quota2=LP_PerfilUsuarioBlackSP;
    @api payment=paymentSP;
    @api isMobile = FORM_FACTOR === 'Small';

    iconProfile = {
        LP_MiPerfilMP,
        LP_MiProfileMP,
        LP_MisDocumentosMP

    }

    changeShowPay(){
        this.showProfile=true;
        this.showMyDueDates=false;
    }

    changeShowPaymentHistory(){
        this.showProfile=false;
        this.showMyDueDates=true;
    }

}