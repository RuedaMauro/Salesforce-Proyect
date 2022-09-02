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
1.0 LAL 21/07/2021 initial version
********************************************************************************/
import { LightningElement } from 'lwc';
//Import Custom Label
import lLaPolarText from '@salesforce/label/c.LP_LaPolarText';
import lInversText from '@salesforce/label/c.LP_InversionistaText';
import lBloqTarText from '@salesforce/label/c.LP_BloqueoTarjetaText';
import lLaPolarUrl from '@salesforce/label/c.LP_LaPolar';
import lInversUrl from '@salesforce/label/c.LP_Inversionista';
import lBloqTarUrl from '@salesforce/label/c.LP_BloqueoTarjeta';
//Import Static Resource
import iBloqTar from '@salesforce/resourceUrl/LP_IconBloqueoTarjeta';

export default class LP_InterestingSitesSP extends LightningElement {

    // static resource to use in the template
    iconSM = {
        iBloqTar
    }

    // Expose the labels to use in the template.
    label = {
        lLaPolarText,
        lInversText,
        lBloqTarText,
        lLaPolarUrl,
        lInversUrl,
        lBloqTarUrl
    };
}