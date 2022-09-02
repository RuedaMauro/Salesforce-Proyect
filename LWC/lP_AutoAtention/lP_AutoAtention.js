/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 26/04/2021
Description  : Javascript - Auto Atention
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Nelson Lepiqueo 			   NL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       NL		  26/04/2021		initial version
********************************************************************************/
import { LightningElement } from 'lwc';
//Import Custom Label
import lSACText from '@salesforce/label/c.LP_SACText';
import lMiCuentaText from '@salesforce/label/c.LP_MiCuentaText';
import lTarjetaLPUrl from '@salesforce/label/c.LP_TarjetaLaPolar';
import lMiCuentaUrl from '@salesforce/label/c.LP_MiCuenta';
import lSACUrl from '@salesforce/label/c.LP_ServicioCliente';
//Import Static Resource
import iTarjetaLP from '@salesforce/resourceUrl/LP_IconTarjetaLaPolar';
import iLogoLP from '@salesforce/resourceUrl/LP_LogoLaPolar';
import iSAC from '@salesforce/resourceUrl/LP_IconSAC';
import iMiCuenta from '@salesforce/resourceUrl/LP_IconMiCuenta';

export default class LP_AutoAtention extends LightningElement { 

    // static resource to use in the template
    iconSM = {
        iTarjetaLP,
        iLogoLP,
        iSAC,
        iMiCuenta
    }

    // Expose the labels to use in the template.
    label = {
        lSACText,
        lMiCuentaText,
        lTarjetaLPUrl,
        lMiCuentaUrl,
        lSACUrl
    };
}