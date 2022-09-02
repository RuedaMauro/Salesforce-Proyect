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
import { LightningElement, track, api } from 'lwc';

import imagenModal from '@salesforce/resourceUrl/LP_TarjetasSP';
import textBloqueo from '@salesforce/label/c.LP_TextBloqueoTarjeta';
import FORM_FACTOR from '@salesforce/client/formFactor';

import getDatos from '@salesforce/apex/LP_CardBlockController.getData';
import bloquear from '@salesforce/apex/LP_CardBlockController.blockCard';
import desbloquear from '@salesforce/apex/LP_CardBlockController.unblockCard';
import LP_BloqueoTarjetaBT from '@salesforce/label/c.LP_BloqueoTarjetaBT'
import LP_LlamarBloqueoTarjetaBT from '@salesforce/label/c.LP_LlamarBloqueoTarjetaBT'
import LP_NroTarjetaLaPolarBT from '@salesforce/label/c.LP_NroTarjetaLaPolarBT'
import LP_TitularBT from '@salesforce/label/c.LP_TitularBT'
import LP_AdicionalBT from '@salesforce/label/c.LP_AdicionalBT'

export default class LP_BloqueoTarjeta_SP extends LightningElement {

    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isModalOpen = true;
    @track texto = textBloqueo;
    @track tarjetas = [];
    @track seleccion = '';

    modalImg = imagenModal;
    isMobile = FORM_FACTOR === 'Small';

    iconLock = {
        LP_BloqueoTarjetaBT,
        LP_LlamarBloqueoTarjetaBT,
        LP_NroTarjetaLaPolarBT,
        LP_TitularBT,
        LP_AdicionalBT
    }
    connectedCallback() {
        
      /**
      * @Description: Gets data for the card.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */


      this.mets();

        
    }


    async mets(){

        this.setBackground().then(() =>
        getDatos()
            .then(result => {
                var listadoTarjetas = [];
                for (var i = 0; i < result.aditionals.length; i++) {
                    var tarjeta = {};
                    if(result.aditionals[i].codBlq == 1){
                        tarjeta.bloqueado = true;
                        tarjeta.messageBlockShow = true;
                        tarjeta.messageBlock = 'Tu tarjeta ha sido bloqueada permanentemente.';
                    }
                    else if (result.aditionals[i].codBlq == 77){
                        tarjeta.bloqueado = true;
                        tarjeta.messageBlockShow = false;
                        tarjeta.messageBlock = '';
                    }
                    else{
                        tarjeta.bloqueado = false;
                        tarjeta.messageBlockShow = false;
                        tarjeta.messageBlock = '';
                    }
                    tarjeta.tarjeta = result.aditionals[i].pan;
                    tarjeta.tarjeta4 = result.aditionals[i].pan.slice(-4);
                    tarjeta.titular = result.aditionals[i].name;
                    tarjeta.esTitular = result.aditionals[i].isPrimary;

                    if(tarjeta.esTitular){
                        listadoTarjetas.unshift(tarjeta);
                    }
                    else{
                        listadoTarjetas.push(tarjeta);
                    }
                }
                this.tarjetas = listadoTarjetas;
               
            }).catch(err => this.error(err)));
    }

    setBackground = () => new Promise(resolve => resolve("success"));

    async handleToggle() {
        this.seleccion = event.target.value;
        if (event.target.checked) {

            /**
             * @Description: Blocks the card.
             * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
             * @Date: 21/07/2021
             */

            bloquear({ pan: this.seleccion.toString() })
                .then(result => {
                    var listaTarjetas = this.tarjetas;
                    if (!result.loginOK){
                        for(var i=0;i<this.tarjetas.length;i++){
                            if (listaTarjetas[i].tarjeta4 == this.seleccion.slice(-4))
                            {
                               
                                listaTarjetas[i].bloqueado = false; 
                            }
                        }
                        this.tarjetas = listaTarjetas;
                    }
                    
                });
        }
        else {

            /**
             * @Description: Unblocks the card.
             * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
             * @Date: 21/07/2021
             */

            desbloquear({ pan: this.seleccion.toString() })
                .then(result => {
                    var listaTarjetas = this.tarjetas;
                    if (!result.loginOK){
                        for(var i=0;i<this.tarjetas.length;i++){
                            if (listaTarjetas[i].tarjeta4 == this.seleccion.slice(-4))
                            {
                             
                                listaTarjetas[i].bloqueado = true; 
                            }
                        }
                
                        this.tarjetas = listaTarjetas;
                    }
                   
                });
        }
    }
}