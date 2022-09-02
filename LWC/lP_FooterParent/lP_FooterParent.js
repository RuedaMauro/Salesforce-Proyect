/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 23/04/2021
Description  : Javascript - Footer Parent
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Nelson Lepiqueo 			   NL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       NL		  23/04/2021		initial version
********************************************************************************/
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import CMF from '@salesforce/label/c.LP_CMFChile';
import CMFText from '@salesforce/label/c.LP_CMFText';
import consRec from '@salesforce/label/c.LP_ConsultaReclamoEmail';
import consRecUrl from '@salesforce/label/c.LP_ConsultaReclamoEmailURL';

export default class LP_FooterParent extends NavigationMixin(LightningElement)  {

    // Expose the labels to use in the template.
    label = {
        CMF,
        CMFText,
        consRec,
        consRecUrl
    };
    
}