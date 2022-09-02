/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 23/04/2021
Description  : Javascript - Social Media
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Nelson Lepiqueo 			   NL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       NL		  23/04/2021		initial version
********************************************************************************/
import { LightningElement } from 'lwc';
//Import Custom Label
import lCallCenterNro from '@salesforce/label/c.LP_CallCenter';
import lCallCenter from '@salesforce/label/c.LP_FooterCallCenter';
import lWhatsapp from '@salesforce/label/c.LP_Whatsapp';
import lWhatsappNro from '@salesforce/label/c.LP_WhatsappNro';
import lFacebook from '@salesforce/label/c.LP_Facebook';
import lTwitter from '@salesforce/label/c.LP_Twitter';
import lYoutube from '@salesforce/label/c.LP_Youtube';
//Import Static Resource
import iCallCenter from '@salesforce/resourceUrl/LP_IconCallCenter';
import iWhatsapp from '@salesforce/resourceUrl/LP_IconWhatsapp';
import iFacebook from '@salesforce/resourceUrl/LP_IconFacebook';
import iTwitter from '@salesforce/resourceUrl/LP_IconTwitter';
import iYoutube from '@salesforce/resourceUrl/LP_IconYoutube';

export default class LP_SocialMedia extends LightningElement {

    // static resource to use in the template
    iconSM = {
        iCallCenter,
        iWhatsapp,
        iFacebook,
        iTwitter,
        iYoutube
    }

    // Expose the labels to use in the template.
    label = {
        lCallCenterNro,
        lCallCenter,
        lWhatsapp,
        lWhatsappNro,
        lFacebook,
        lTwitter,
        lYoutube
    };
}