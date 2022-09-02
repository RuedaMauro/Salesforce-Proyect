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
1.0 GLB 14/06/2021 initial version
********************************************************************************/
import { LightningElement, track } from 'lwc';

import imagenModal from '@salesforce/resourceUrl/LP_TarjetasSP';
import textBloqueo from '@salesforce/label/c.LP_TextBloqueoTarjeta';


export default class LP_BloqueoModal_SP extends LightningElement {

    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isModalOpen = true;
    @track texto = textBloqueo;
    tarjetas = [{"Id": 0, "titular":"Daniel", "tarjeta":1234, bloqueado: false}, {"Id": 0, "titular":"Daniel", "tarjeta":1234, bloqueado: false}, {"Id": 0, "titular":"Daniel", "tarjeta":1234, bloqueado: false}];
    modalImg = imagenModal;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }
}