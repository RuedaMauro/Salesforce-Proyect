import { LightningElement,api,track } from 'lwc';
import LP_LogofooterSP from '@salesforce/resourceUrl/LP_LogofooterSP'
import LP_SecureSP from '@salesforce/resourceUrl/LP_SecureSP'
import LP_TwitterfooterSP from '@salesforce/resourceUrl/LP_TwitterfooterSP'
import LP_CandadofooterSP from '@salesforce/resourceUrl/LP_CandadofooterSP'
import LP_NubefooterSP from '@salesforce/resourceUrl/LP_NubefooterSP'
import LP_WhatsappfooterSP from '@salesforce/resourceUrl/LP_WhatsappfooterSP'
import LP_YoutubefooterSP from '@salesforce/resourceUrl/LP_YoutubefooterSP'
import LP_FacebookfooterSP from '@salesforce/resourceUrl/LP_FacebookfooterSP'
import LP_DondeUsarModalSP from '@salesforce/resourceUrl/LP_DondeUsarModalSP'
import LP_FooterColumnTarjetaLaPolar from '@salesforce/label/c.LP_FooterColumnTarjetaLaPolar'
import LP_FooterColumnLaPolar from '@salesforce/label/c.LP_FooterColumnLaPolar'
import LP_WhatsappNro from '@salesforce/label/c.LP_WhatsappNro'
import LP_FooterColumnEmpresa from '@salesforce/label/c.LP_FooterColumnEmpresa'
import LP_DondeUsarModalSPLabel from '@salesforce/label/c.LP_DondeUsarModalSP'
import LP_BloqueoTarjetaNro from '@salesforce/label/c.LP_BloqueoTarjetaNro'
import LP_FooterBloqueoTarjeta from '@salesforce/label/c.LP_FooterBloqueoTarjeta'
import LP_Inversionista from '@salesforce/label/c.LP_Inversionista'
import LP_CMFChile from '@salesforce/label/c.LP_CMFChile'
import LP_Facebook from '@salesforce/label/c.LP_Facebook'
import LP_Twitter from '@salesforce/label/c.LP_Twitter'
import LP_Youtube from '@salesforce/label/c.LP_Youtube'
import LP_CallCenter from '@salesforce/label/c.LP_CallCenter'
import LP_FooterCallCenter from '@salesforce/label/c.LP_FooterCallCenter'
import LP_LaPolar from '@salesforce/label/c.LP_LaPolar'
import LP_Whatsapp from '@salesforce/label/c.LP_Whatsapp'
import LP_CMFFooter from '@salesforce/label/c.LP_CMFFooter'
import LP_ServicioalClienteFooter from '@salesforce/label/c.LP_ServicioalClienteFooter'
import LP_WhatsappFooter from '@salesforce/label/c.LP_WhatsappFooter'
import LP_BloqueoTarjetaFooter from '@salesforce/label/c.LP_BloqueoTarjetaFooter'
import LP_MsjBloquearTarjetaFooter from '@salesforce/label/c.LP_MsjBloquearTarjetaFooter'
import LP_SiguenosenFooter from '@salesforce/label/c.LP_SiguenosenFooter'
import LP_TarjetaLaPolarFooter from '@salesforce/label/c.LP_TarjetaLaPolarFooter'
import LP_LaPolarFooter from '@salesforce/label/c.LP_LaPolarFooter'
import LP_EmpresaFooter from '@salesforce/label/c.LP_EmpresaFooter'
import LP_SitioSeguroFooter from '@salesforce/label/c.LP_SitioSeguroFooter'
import CMFFooter from '@salesforce/label/c.LP_CMFFooter'
import LP_DatosLaPolarFooter from '@salesforce/label/c.LP_DatosLaPolarFooter'

export default class LP_FooterParentSP extends LightningElement

{

    iconFooter = {
        LP_LogofooterSP,
        LP_SecureSP,
        LP_TwitterfooterSP,
        LP_CandadofooterSP,
        LP_NubefooterSP,
        LP_WhatsappfooterSP,
        LP_YoutubefooterSP,
        LP_FacebookfooterSP,
        LP_DondeUsarModalSP,
        LP_DondeUsarModalSPLabel,
        LP_WhatsappNro,
        LP_BloqueoTarjetaNro,
        LP_Inversionista,
        LP_FooterBloqueoTarjeta,
        LP_CMFChile,
        LP_Facebook,
        LP_Twitter,
        LP_Youtube,
        LP_CallCenter,
        LP_FooterCallCenter,
        LP_LaPolar,
        LP_Whatsapp,
        LP_CMFFooter,
        LP_ServicioalClienteFooter,
        LP_WhatsappFooter,
        LP_BloqueoTarjetaFooter,
        LP_MsjBloquearTarjetaFooter,
        LP_SiguenosenFooter,
        LP_TarjetaLaPolarFooter,
        LP_LaPolarFooter,
        LP_EmpresaFooter,
        LP_SitioSeguroFooter,
        LP_DatosLaPolarFooter
    }

    @api isModalOpen = false;
    @track footerColumn0;
    @track footerColumn1;
    @track footerColumn2;
    @track textEmp = CMFFooter;
   

    connectedCallback(){
        var footerColumn0 = [];
        var footerColumn1 = [];
        var footerColumn2 = [];
        var allColumns = [
            LP_FooterColumnTarjetaLaPolar,
            LP_FooterColumnLaPolar,
            LP_FooterColumnEmpresa,
        ];

        var column = allColumns[0].split(',');
        column.forEach(function(item){
               var columnOBJ = [];
   
                var tt = item.split('|');

    
                if(!tt[2]){
                    tt[2] = 'self';
                }
    
                columnOBJ = 
                    {
                        "label" : tt[0],
                        "URL" : tt[1],
                        "target" : tt[2],
                        "isModal": tt[0] == 'Dónde usarla' ? true : false
                    }
                ;


            footerColumn0.push(columnOBJ);
            
        });

        this.footerColumn0 = footerColumn0;

        var column = allColumns[1].split(',');
        column.forEach(function(item){
               var columnOBJ = [];
   
                var tt = item.split('|');

    
                if(!tt[2]){
                    tt[2] = 'self';
                }
                if(!tt[1]){
                    tt[1] = 'www.google.com';
                }
                
                columnOBJ = 
                    {
                        "label" : tt[0],
                        "URL" : tt[1],
                        "target" : tt[2],
                    }
                ;


            footerColumn1.push(columnOBJ);
            
        });

        this.footerColumn1 = footerColumn1;

        var column = allColumns[2].split(',');
        column.forEach(function(item){
               var columnOBJ = [];
   
                var tt = item.split('|');

    
                if(!tt[2]){
                    tt[2] = 'self';
                }
                if(!tt[1]){
                    tt[1] = 'www.google.com';
                }
                
                columnOBJ = 
                    {
                        "label" : tt[0],
                        "URL" : tt[1],
                        "target" : tt[2],
                    }
                ;


            footerColumn2.push(columnOBJ);
            
        });

        this.footerColumn2 = footerColumn2;
        

    }


    whereUseModal() {        
         this.isModalOpen= true;
    }


    closeModal(){
        this.isModalOpen = false;
    }

  
    stopPropagation(event) {
        event.stopPropagation();
    }


    
}