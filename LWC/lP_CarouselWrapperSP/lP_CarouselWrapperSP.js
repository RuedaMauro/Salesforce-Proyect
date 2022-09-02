import { LightningElement } from 'lwc';

import imagenes from '@salesforce/resourceUrl/LP_BannerSP'; //LP_AvanceXLSP
import getData from '@salesforce/apex/LP_CarouselController.getCarousel'; 
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_CarouselWrapperSP extends LightningElement {

    listaCarousel = [];
    isMobile = FORM_FACTOR === 'Small';
    showCarousel = false;

    connectedCallback(){

        getData({ isMobile: this.isMobile})
        .then( result => {
            var carr = [];   
            var lista = [];
            result.forEach(function(item,index){
                carr = {
                    "LP_VinculoPublico__c": result[index].LP_VinculoPublico__c,
                    "LP_url_Imagen__c":  imagenes + '/' + result[index].LP_NombreImagen__c, 
                    "LP_Orden__c": result[index].LP_Orden__c,
                    "LP_Categoria__c": result[index].LP_Categoria__c 
                };
                lista.push(carr);
            });
            this.showCarousel = true;
            this.listaCarousel = lista;
        })
        .catch(error => {
        });
    }
}