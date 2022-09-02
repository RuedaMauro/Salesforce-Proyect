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
    LightningElement
} from 'lwc';

import avanceLogoResource from '@salesforce/resourceUrl/LP_AvanceSP';
import avanceXLLogoResource from '@salesforce/resourceUrl/LP_AvanceXLSP';

import tarjetaNegra from '@salesforce/resourceUrl/LP_TarjetaNegraSP';


import tarjetaRoja from '@salesforce/resourceUrl/LP_TarjetaRojaSP';

import LP_SimularAvance from '@salesforce/label/c.LP_SimularAvance';


import FORM_FACTOR from '@salesforce/client/formFactor';

import getData from '@salesforce/apex/LP_HomeController.getHomeData3'; // devuelve bad request
import getDueDates from '@salesforce/apex/LP_HomeController.getHomeData1'; // devuelve bien
import getVenc from '@salesforce/apex/LP_HomeController.getHomeData4'; // crashea
import getReneg from '@salesforce/apex/LP_HomeController.getHomeData5'; // crashea 
import LP_EstadodeCuentaCalugas from '@salesforce/label/c.LP_EstadodeCuentaCalugas'
import LP_UltimaFacturacionCalugas from '@salesforce/label/c.LP_UltimaFacturacionCalugas'
import LP_PagarantesdeCalugas from '@salesforce/label/c.LP_PagarantesdeCalugas'
import LP_CupodisponibleCalugas from '@salesforce/label/c.LP_CupodisponibleCalugas'
import LP_TotalapagarCalugas from '@salesforce/label/c.LP_TotalapagarCalugas'
import LP_MsjEstadoCuentaCalugas from '@salesforce/label/c.LP_MsjEstadoCuentaCalugas'
import LP_MontoDisponibleCalugas from '@salesforce/label/c.LP_MontoDisponibleCalugas'
import LP_PideHoyCalugas from '@salesforce/label/c.LP_PideHoyCalugas'
import LP_SeguroFullSaludCalugas from '@salesforce/label/c.LP_SeguroFullSaludCalugas'
import LP_MsjPideHoyCalugas from '@salesforce/label/c.LP_MsjPideHoyCalugas'
import LP_RefinanciamientoCalugas from '@salesforce/label/c.LP_RefinanciamientoCalugas'
import LP_RefinanciarMontoCalugas from '@salesforce/label/c.LP_RefinanciarMontoCalugas'
import LP_NCuotasCalugas from '@salesforce/label/c.LP_NCuotasCalugas'
import LP_OfertasExclusivasCalugas from '@salesforce/label/c.LP_OfertasExclusivasCalugas'
import LP_AprovechaOfertaExclusivasCalugas from '@salesforce/label/c.LP_AprovechaOfertaExclusivasCalugas'
import LP_MsjAprovechaOfertasCalugas from '@salesforce/label/c.LP_MsjAprovechaOfertasCalugas'
import LP_ResumendeTuCuentaRTC from '@salesforce/label/c.LP_ResumendeTuCuentaRTC'
import LP_CupodeCompraRTC from '@salesforce/label/c.LP_CupodeCompraRTC'
import LP_CupoUtilizadoRTC from '@salesforce/label/c.LP_CupoUtilizadoRTC'
import LP_CupoDisponibleRTC from '@salesforce/label/c.LP_CupoDisponibleRTC'
import LP_TotalaPagarRTC from '@salesforce/label/c.LP_TotalaPagarRTC'
import LP_BtnPagarMiCuentaRTC from '@salesforce/label/c.LP_BtnPagarMiCuentaRTC'
import LP_BtnVerEstadodeCuentaCalugas from '@salesforce/label/c.LP_BtnVerEstadodeCuentaCalugas'
import LP_PagaTuCuotaCalugas from '@salesforce/label/c.LP_PagaTuCuotaCalugas'
import LP_BtnVerSeguroFullSaludCalugas from '@salesforce/label/c.LP_BtnVerSeguroFullSaludCalugas'
import LP_BtnSaberMasDetallesCalugas from '@salesforce/label/c.LP_BtnSaberMasDetallesCalugas'
import LP_BtnSimularCalugas from '@salesforce/label/c.LP_BtnSimularCalugas'
import LP_SimularAvanceCalugas from '@salesforce/label/c.LP_SimularAvanceCalugas'
import LP_SimularAvanceXLCalugas from '@salesforce/label/c.LP_SimularAvanceXLCalugas'
import LP_URLVerSeguroFullSaludCalugas from '@salesforce/label/c.LP_URLVerSeguroFullSaludCalugas'
import LP_URLSaberMasDetallesCalugas from '@salesforce/label/c.LP_URLSaberMasDetallesCalugas'
import LP_TarjetaVisaLaPolarRTC from '@salesforce/label/c.LP_TarjetaVisaLaPolarRTC'
import LP_TarjetaLaPolarRTC from '@salesforce/label/c.LP_TarjetaLaPolarRTC'


export default class LP_CalugasSP extends LightningElement {

    avanceLogo = avanceLogoResource;
    fechaFact = '';
    monto = '';
    disp = '';
    fechaVenc = '';
    showCaluga1 = false;
    showCaluga2 = false;
    showCaluga3 = false;
    deudaPendiente = false;
    montoDisp = '';
    labelCaluga1 = LP_BtnVerEstadodeCuentaCalugas;
    labelCaluga2 = LP_SimularAvanceCalugas;
    labelCaluga3 = LP_BtnSaberMasDetallesCalugas;
    tipoTarjeta = '';
    numeroTarjeta = '';
    cupoCompra = '';
    nombreDeTarjeta = LP_TarjetaVisaLaPolarRTC;
    cupoUtilizado = '';
    cupoDisponible = '';
    totalPagar = '';
    isMobile = FORM_FACTOR === 'Small';
    refinanciarMonto = '';
    cuotasMin = '';
    cuotasMax = '';
    imagenTarjeta = tarjetaNegra;

    iconCal = {
        LP_EstadodeCuentaCalugas,
        LP_UltimaFacturacionCalugas,
        LP_PagarantesdeCalugas,
        LP_CupodisponibleCalugas,
        LP_TotalapagarCalugas,
        LP_MsjEstadoCuentaCalugas,
        LP_MontoDisponibleCalugas,
        LP_PideHoyCalugas,
        LP_SeguroFullSaludCalugas,
        LP_MsjPideHoyCalugas,
        LP_RefinanciamientoCalugas,
        LP_RefinanciarMontoCalugas,
        LP_NCuotasCalugas,
        LP_OfertasExclusivasCalugas,
        LP_AprovechaOfertaExclusivasCalugas,
        LP_MsjAprovechaOfertasCalugas,
        LP_ResumendeTuCuentaRTC,
        LP_CupodeCompraRTC,
        LP_CupoUtilizadoRTC,
        LP_CupoDisponibleRTC,
        LP_TotalaPagarRTC,
        LP_BtnPagarMiCuentaRTC


    }


    connectedCallback() {





        /**
         * @Description: Gets data for all Calugas.
         * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
         * @Date: 21/07/2021
         */

        this.mets();



    }

    async mets() {

        this.setBackground().then(() =>


            getVenc()

            .then(result => {


                this.fechaFact = result.fechaVencimiento;
                this.deudaPendiente = result.deudaPendiente;
                if (this.deudaPendiente == true) {
                    this.fechaVenc = result.fechaVencimiento;
                }
                if (result.deudatotal == 0) {
                    this.totalPagar = result.deudatotal;
                } else {
                    this.totalPagar = new Intl.NumberFormat('de-DE').format(result.deudatotal);
                }
            }).catch(err => this.error(err)));

        this.setBackground().then(() =>

            getReneg()
            .then(result => {



                if (result.renegSituation) {
                    this.cuotasMin = result.cuotamin;
                    this.cuotasMax = result.cuotamax;
                    this.refinanciarMonto = this.totalPagar;
                    this.labelCaluga3 = LP_BtnSimularCalugas;
                    this.showCaluga3 = true;
                }

            }).catch(err => this.error(err)));

        this.setBackground().then(() =>

            getData()
            .then(result => {


                if (this.deudaPendiente == true) {
                    this.monto = new Intl.NumberFormat('de-DE').format(result.utilcompra);
                    this.disp = new Intl.NumberFormat('de-DE').format(result.dispcompra);
                    this.showCaluga1 = true;
                    this.labelCaluga1 = LP_PagaTuCuotaCalugas;
                }

                if (parseInt(result.dispavxl) > 0) {

                    this.avanceLogo = avanceXLLogoResource;
                    this.montoDisp = new Intl.NumberFormat('de-DE').format(result.dispavxl);
                    this.labelCaluga2 = LP_SimularAvanceXLCalugas;
                } else if (parseInt(result.dispav) > 0) {

                    this.avanceLogo = avanceLogoResource;
                    this.montoDisp = new Intl.NumberFormat('de-DE').format(result.dispav);
                    this.labelCaluga2 = LP_SimularAvanceCalugas;
                } else {

                    this.showCaluga2 = true;
                    this.labelCaluga2 = LP_BtnVerSeguroFullSaludCalugas;
                }


                this.cupoCompra = new Intl.NumberFormat('de-DE').format(result.cupocompras);
                this.cupoUtilizado = new Intl.NumberFormat('de-DE').format(result.utilcompra);
                this.cupoDisponible = new Intl.NumberFormat('de-DE').format(result.dispcompra);



            }).catch(err => this.error(err)));

        this.setBackground().then(() =>

            getDueDates()
            .then(result => {



                if (result.tarjetaCod == 'VISA') {
                    this.nombreDeTarjeta = LP_TarjetaVisaLaPolarRTC;
                    this.imagenTarjeta = tarjetaNegra;
                } else {
                    this.nombreDeTarjeta = LP_TarjetaLaPolarRTC;
                    this.imagenTarjeta = tarjetaRoja;
                }

                this.tipoTarjeta = result.tarjetaCod;
                this.numeroTarjeta = 'XXXX XXXX XXXX ' + result.tarjetaEmitidaPan.slice(-4);

            }).catch(err => this.error(err)));

    }

    setBackground = () => new Promise(resolve => resolve("success")); // never rejects

    handleClickCaluga2() {


        if (this.showCaluga2) {
            window.open(LP_URLVerSeguroFullSaludCalugas, '_blank');
        } else {
            window.open(LP_SimularAvance, '_blank');
        }
    }

    handleClickCaluga3() {


        if (this.showCaluga3) {
            window.open("pagos-de-cuenta?clicked=refinanciamiento", '_self');

        } else {
            window.open(LP_URLSaberMasDetallesCalugas, '_blank');
        }
    }

    handleClickCaluga1() {
        window.open("mi-cuenta?clicked=estado-de-cuenta", '_self');
    }

    goToPayAccount() {
        window.open("pagos-de-cuenta", '_self')
    }
}