/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 05/07/2021
Description : My Account Layout JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 05/07/2021 initial version
********************************************************************************/

import { LightningElement, api,track } from 'lwc';
import perfilSP from '@salesforce/resourceUrl/LP_PerfilUsuarioBlackSP';
import facturasSP from '@salesforce/resourceUrl/LP_FacturaSP';
import cuposSP from '@salesforce/resourceUrl/LP_MisCuposSP';
import ecuentaSP from '@salesforce/resourceUrl/LP_StateAccountSP';
import vencimientosSP from '@salesforce/resourceUrl/LP_ProxVencimientosSP';
import flechaSP from '@salesforce/resourceUrl/LP_FlechaItemsSP';
import FORM_FACTOR from '@salesforce/client/formFactor';
import getCreatedPinData from '@salesforce/apex/LP_MyDigitalCardController.getCreatedPinData';
import getDocs from '@salesforce/apex/LP_MyAccountController.getDocs'
import getDocument from '@salesforce/apex/LP_MyAccountController.getDocument'
import getClientTypeData from '@salesforce/apex/LP_MyAccountController.getClientTypeData';
import LP_MiTarjetaDigitalMC from '@salesforce/label/c.LP_MiTarjetaDigitalMC'
import LP_MisCuposMC from '@salesforce/label/c.LP_MisCuposMC'
import LP_MovNoFacturadosMC from '@salesforce/label/c.LP_MovNoFacturadosMC'
import LP_ProximosVencimientosMC from '@salesforce/label/c.LP_ProximosVencimientosMC'
import LP_EstadodeCuentaMC from '@salesforce/label/c.LP_EstadodeCuentaMC'
import LP_RevisarEstadoCuentaMC from '@salesforce/label/c.LP_RevisarEstadoCuentaMC'
import LP_DescargarEstadoCuentaMC from '@salesforce/label/c.LP_DescargarEstadoCuentaMC'
import LP_MiCuentaHome from '@salesforce/label/c.LP_MiCuentaHome'
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';
import LP_ViewPdfURL from '@salesforce/label/c.LP_ViewPdfURL'

export default class LP_MyAccountLayout extends LightningElement {
    showAccountState=true ;
    showCardLimits=false;
    showUnbilledMovements=false;
    showUpcomingMaturities=false;
    showDigitalAccount= false;
    @api showButtonDigitalAccount=false;
    noAccountStatements=false;
    @api profile=perfilSP;
    @api rut;
    @api pan;
    @api dv;
    @api dates;
    @api months = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
    @api arrow=flechaSP;
    @api quota=cuposSP;
    @api eAccount=ecuentaSP;
    @track docbase64;
    @api fecemi='20191027';
    @api options2;
    @api options;
    @api maturities=vencimientosSP;
    @api unbilled=facturasSP;
    @api monthOfReport;    
    @api isMobile = FORM_FACTOR === 'Small';
    @api isBase=false;
    @api isErrorsDate=false;
    @api errorsDate='No posees EE.CC correspondiente a ese mes';
    @api errorsText='No se presentan próximos vencimientos';
    @api showPDF=false;
    @api value1;
    @api value2;
    
    firstMonth='';
    firstYear='';
    firstFecemi='';
    
    iconMyaccount = {
        LP_MiTarjetaDigitalMC,
        LP_MisCuposMC,
        LP_MovNoFacturadosMC,
        LP_ProximosVencimientosMC,
        LP_EstadodeCuentaMC,
        LP_RevisarEstadoCuentaMC,
        LP_DescargarEstadoCuentaMC,
        LP_MiCuentaHome

    }

    connectedCallback() {
    
           var query = window.location.search.substring(1);
           this.showButtonDigitalAccount = true;
           var vars = query;
                   var pair = vars.split("=");
                   if(pair[0] == "clicked"){
                   if(pair[1]=='mi-tarjeta-digital') this.changeShowDigitalAccount();
                   if(pair[1]=='mis-cupos') this.changeShowCardLimits();
                   if(pair[1]=='movimientos-no-facturados') this.changeShowUnbilledMovements();
                   if(pair[1]=='proximos-vencimientos') this.changeShowUpcomingMaturities();
                   if(pair[1]=='estado-de-cuenta') this.changeShowAccountState();
                   }
                   
            getCreatedPinData()
            .then((result) => {
                    if(result.VisaClient==false){
                        this.showButtonDigitalAccount=false;
                    }
            })
            

            getDocs()
            .then((result) => {
                if(result.loginOK){

                    
                    if(result.docs[0].rut == ""){
                        this.noAccountStatements = true;
                    }
                    else{
                        this.rut = result.docs[0].rut;
                        this.pan = result.docs[0].pan;
                        this.dv = result.docs[0].dv;
                        this.rut = this.rut.toString() + "-" + this.dv.toString();
                        this.dates = result.docs;
                        var opcionesAño = [];
                        var opcionesMes = [];
                        var años = [];
                        var meses = [];

                        this.dates.forEach(element => {
                            
                            if(años.includes(element.proxperfac.slice(0,4))==false){
                                años.push(element.proxperfac.slice(0,4));
                            }
                            var i = element.proxperfac.slice(4,6);
                            if(i[0]==0){
                                i=i[1];
                            }
                            i=i-1;
                            if(meses.includes(i)==false){
                                meses.push(i);
                            }
                        });
                        var mesesSorted = meses.sort();
                        años.forEach(element => {
                            var array = {label:element,value:element};
                            opcionesAño.push(array);
                        });
                        mesesSorted.forEach(element => {
                            var array = {label:this.months[element],value:this.months[element]};
                            opcionesMes.push(array);
                        });

                        this.options2 = opcionesAño;
                        this.options = opcionesMes;

                        this.value1 = this.options2[0].label; 
                        this.value2 = this.options[0].label;    
                    }
                    if(this.value2=='undefined' || this.value1=='undefined') {
                        this.value2='';
                        this.value1='';
                    }
                    else{
                        this.fecemi = result.docs[0].proxperfac;
                        this.value2 = result.docs[0].year;
                        this.value1 = result.docs[0].month;
                        this.showPDF = true;
                    }
                }
                

            })
           
        }
            

    handleChange(event) {
       
        this.value = event.detail.value.toString();
        this.isErrorsDate=false;
        for(var i=0;i<this.months.length;i++){
            if(this.months[i]==this.value){
                var a=i+1;
                if(a<10){
                    a='0'+a.toString();
                }
                else{
                    a=a.toString();
                }

            }
        }

        var b= this.value2.toString();
        var c= b+a;
        var d= this.fecemi;
        for(var j=0;j<this.dates.length;j++){
            if(this.dates[j].proxperfac.slice(0,6)==c){
                this.fecemi=this.dates[j].proxperfac;
            }
        }
        if(d==this.fecemi){
            this.isErrorsDate=true;
            this.showPDF=false;
        }
        else{
            this.showPDF=true;
        }
    }

    handleChange2(event) {
        this.value2 = event.detail.value;
        this.showPDF=true;
        this.isErrorsDate=false;
        for(var i=0;i<this.months.length;i++){
            if(this.months[i]==this.value){
                var a=i+1;
                if(a<10){
                    a='0'+a.toString();
                }
                else{
                    a=a.toString();
                }

            }
        }

        var b= this.value2.toString();
        var c= b+a;
        var d= this.fecemi;
        for(var j=0;j<this.dates.length;j++){
            if(this.dates[j].proxperfac.slice(0,6)==c){
                this.fecemi=this.dates[j].proxperfac;
                if(this.dates[j].proxperfac=='undefined'){
                    this.isErrorsDate=true;
                }
            }
        }
        if(d==this.fecemi){
            this.isErrorsDate=true;
            this.showPDF=false;
        }
        else{
            this.showPDF=true;
        }
    }

    handleMonth(event){
        this.monthOfReport = event.target.value;
     }

    changeShowAccountState(event){
        this.showAccountState=true;
        this.showCardLimits=false;
        this.showUnbilledMovements=false;
        this.showUpcomingMaturities=false;
        this.showDigitalAccount=false;
    }
    changeShowCardLimits(){
        this.showCardLimits=true;
        this.showAccountState=false;
        this.showUnbilledMovements=false;
        this.showUpcomingMaturities=false;
        this.showDigitalAccount=false;
    }
    changeShowUnbilledMovements(){
        this.showUnbilledMovements=true;
        this.showCardLimits=false;
        this.showAccountState=false;
        this.showUpcomingMaturities=false;
        this.showDigitalAccount=false;
    }
    changeShowUpcomingMaturities(){
        this.showUpcomingMaturities=true;
        this.showAccountState=false;
        this.showCardLimits=false;
        this.showUnbilledMovements=false;
        this.showDigitalAccount=false;
    }

    changeShowDigitalAccount(){
        this.showUpcomingMaturities=false;
        this.showAccountState=false;
        this.showCardLimits=false;
        this.showUnbilledMovements=false;
        this.showDigitalAccount=true;
    }

    changeShowCreatePIN(){
        this.showUpcomingMaturities=false;
        this.showAccountState=false;
        this.showCardLimits=false;
        this.showUnbilledMovements=false;
        this.showDigitalAccount=false;
    }

    loadpdf(event){
        alert(this.docbase64);
        this.template.querySelector('iframe').contentWindow.postMessage(this.docbase64, window.location.origin);
    }
    
    get  base64(){return 'data:application/pdf;base64,'+this.docbase64;}
    get  srcVF(){return LP_ViewPdfURL +this.rut+'&pan='+this.pan+'&fecemi='+this.fecemi;}
}