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
1.0 LAL 11/08/2021 initial version
********************************************************************************/

import { LightningElement,api } from 'lwc';
import getData from '@salesforce/apex/LP_DocumentController.LP_getDataClient';
import getDemographicDataClient from '@salesforce/apex/LP_DocumentController.LP_getDemographicDataClient';
import LP_CallCenter from '@salesforce/label/c.LP_CallCenter';
import LP_FooterCallCenter from '@salesforce/label/c.LP_FooterCallCenter';
import textTiendas from '@salesforce/label/c.LP_UbicacionTiendas';
import LP_NubefooterSP from '@salesforce/resourceUrl/LP_ChatdotsSP';
import LP_AlertCicleSP from '@salesforce/resourceUrl/LP_AlertCicleSP';
import LP_UbicacionTiendas from '@salesforce/label/c.LP_UbicacionTiendas';
import LP_MiPerfilMP from '@salesforce/label/c.LP_MiPerfilMP'
import LP_DatosPersonalesMP from '@salesforce/label/c.LP_DatosPersonalesMP'
import LP_NombreMP from '@salesforce/label/c.LP_NombreMP'
import LP_ApellidoPaternoMP from '@salesforce/label/c.LP_ApellidoPaternoMP'
import LP_ApellidoMaternoMP from '@salesforce/label/c.LP_ApellidoMaternoMP'
import LP_RutMP from '@salesforce/label/c.LP_RutMP'
import LP_FechaNacimientoMP from '@salesforce/label/c.LP_FechaNacimientoMP'
import LP_CorreoElectronicoMP from '@salesforce/label/c.LP_CorreoElectronicoMP'
import LP_TelefonoFijoMP from '@salesforce/label/c.LP_TelefonoFijoMP'
import LP_TelefonoMovilMP from '@salesforce/label/c.LP_TelefonoMovilMP'
import LP_DatosParticulatesMP from '@salesforce/label/c.LP_DatosParticulatesMP'
import LP_DireccionMP from '@salesforce/label/c.LP_DireccionMP'
import LP_NumeroDireccionMP from '@salesforce/label/c.LP_NumeroDireccionMP'
import LP_ComunaMP from '@salesforce/label/c.LP_ComunaMP'
import LP_ServicioalClienteFooter from '@salesforce/label/c.LP_ServicioalClienteFooter'
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_MyProfileSP extends LightningElement {

    @api isMobile = FORM_FACTOR === 'Small';

    @api name;
    @api last_Name_1;
    @api last_Name_2;
    @api day_birth;
    @api comuna;
    @api no_movil;
    @api domicilio;
    @api rut;
    @api textHelp = textTiendas;
    @api email

    iconHelp={
        LP_CallCenter,
        LP_FooterCallCenter,
        LP_NubefooterSP,
        LP_AlertCicleSP,
        LP_UbicacionTiendas,
        LP_MiPerfilMP,
        LP_DatosPersonalesMP,
        LP_NombreMP,
        LP_ApellidoPaternoMP,
        LP_ApellidoMaternoMP,
        LP_RutMP,
        LP_FechaNacimientoMP,
        LP_CorreoElectronicoMP,
        LP_TelefonoFijoMP,
        LP_TelefonoMovilMP,
        LP_DatosParticulatesMP,
        LP_DireccionMP,
        LP_NumeroDireccionMP,
        LP_ComunaMP,
        LP_ServicioalClienteFooter
    }

    connectedCallback(){

        /**
      * @Description: Gets client data.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 11/08/2021
      */


        this.mets();

        

    }

    async mets(){

        this.setBackground().then(() =>
        getDemographicDataClient()
        .then( result => {

            
            if(result.loginOK==true){
    
                var sliceEmail;
                if(result.email != ':'){
                    
                    var string = result.email.split("@");
                    sliceEmail = string[0].slice(0,4) + "***" + "@" + string[1];
                    
                }
                else{
                    sliceEmail = "-";
                    
                }

                
                
                   
            }      
        }).catch(err => this.error(err)));


        this.setBackground().then(() =>
             getData()
               .then( result => {

                
                   
                   if(result.loginOK==true){
           

                       
                       var year = result.day_birth.slice(0,2);
                       var day = result.day_birth.slice(6,8); 
                       
                       this.day_birth = day + "/" + "**" + "/" + year + "**";
                       this.name = result.name;
                       this.last_Name_1 = result.last_Name_1;
                       this.last_Name_2 = result.last_Name_2;

                       this.comuna = result.comuna; 
                       this.no_movil = " " + result.no_movil.slice(0,4) + '-' + '**' + result.no_movil.slice(6,8); 
                       this.domicilio = result.domicilio + "****"; 
                       this.tipoCasa = result.home_type == '' ? "-" : result.home_type; 
                       this.rut = result.rut + '-' + result.dv; 
                       this.email = sliceEmail;

                      
                   }      
               }).catch(err => this.error(err)));



    }

    setBackground = () => new Promise(resolve => resolve("success"));



}