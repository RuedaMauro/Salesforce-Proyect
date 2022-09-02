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
import { LightningElement } from 'lwc';

import getFiles from '@salesforce/apex/LP_InfoUtil.getFiles'
import LogoLP from '@salesforce/resourceUrl/LP_LogoDocSP';
import FORM_FACTOR  from '@salesforce/client/formFactor';
import LP_ContratosPlanesDescuentoCP from '@salesforce/label/c.LP_ContratosPlanesDescuentoCP'
    
const columns = [
  { label: 'Nombre documento', fieldName: 'link', type: 'url',cellAttributes: { alignment: 'left' }, typeAttributes: {label: { fieldName: 'linkLabel' }}, hideDefaultActions: true},
  { label: 'Fecha', fieldName: 'fechaVigencia', hideDefaultActions: true, cellAttributes: { alignment: 'center' }},
  { label: 'Vigencia', fieldName: 'vigencia', hideDefaultActions: true, cellAttributes: { alignment: 'center' } }];

export default class LP_InfoUtilSP extends LightningElement {

    isMobile = FORM_FACTOR === 'Small';
    data = [];
    
    columns = columns;
    logo = LogoLP;

    iconCP = {
      LP_ContratosPlanesDescuentoCP

  }
    
    async connectedCallback() {

      /**
      * @Description: Gets files.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */
        
        getFiles()
            .then( result => {
                var datos = [];
                //datos.push({'link':' ','vigencia':'Estado', 'fechaVigencia':'Fecha de vigencia', 'linkLabel':'Nombre documento'});
                for (var i in result) { 
                  console.log(result[i]);
                    var arch = {};
                    
                    var fecha = result[i].LP_FechaVigencia__c;
                    arch.vigencia = result[i].LP_EstadoVigencia__c;
                    arch.fechaVigencia = fecha.substring(8,10) + '/' + fecha.substring(5,7)+ '/' +fecha.substring(0,4);
                    arch.link =  result[i].LP_VinculoPublico__c;
                    arch.linkLabel = result[i].LP_NombreDocumento__c;

                    datos.push(arch);
                  }

                this.data = datos;
            })
            .catch(error => {
            });

    }
}