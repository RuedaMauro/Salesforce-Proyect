/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 27/04/2021
Description  : Javascript - Body Parent
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Leonardo Muñoz 			   LM
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       NL		  27/04/2021		initial version
********************************************************************************/
import { LightningElement, wire, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import lblLinkTC from '@salesforce/label/c.LP_TerminoCondic';
import lblLinkTCPerInf from '@salesforce/label/c.LP_TerminoCondic_PI';
import lblTCTxt1 from '@salesforce/label/c.LP_TerminoCondic_Txt1';
import lblTCTxt2 from '@salesforce/label/c.LP_TerminoCondic_Txt2';
import lblTCTxt3 from '@salesforce/label/c.LP_TerminoCondic_Txt3';
import lblTCTxt4 from '@salesforce/label/c.LP_TerminoCondic_Txt4';

/**
  *  @Description: Show Terms Condition
  *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
  *  @Date:        27/04/2021
  */
  export default class LP_TermsCondition extends NavigationMixin(LightningElement) {
  @api usedInComunity;
  @api labelTC1 = lblTCTxt1;
  @api labelTC2 = lblTCTxt2;
  @api labelTC3 = lblTCTxt3;
  @api labelTC4 = lblTCTxt4;
  @api valTermCondic;

  renderedCallback() {
    if (this.valTermCondic == 'true'){
        this.template.querySelector('.check').checked = true;
    }
  }
  navigateToFilesTC() {
  
    this[NavigationMixin.Navigate]({
      type: 'standard__webPage',
      attributes: {
          url: lblLinkTC
      }
    }, false );
  }
/**
  *  @Description: open page Terms Condition
  *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
  *  @Date:        27/04/2021
  */
 navigateToFilesTCDT() {

    this[NavigationMixin.Navigate]({
      type: 'standard__webPage',
      attributes: {
          url: lblLinkTCPerInf
      }
    }, false );
  }
/**
  *  @Description: event for check Terms Condition
  *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
  *  @Date:        25/04/2021
  */
 handleChangeChk(event){
   
    const custEvent = new CustomEvent(
      'callpasstoparent', {
          detail: event.target.checked 
      });
    this.dispatchEvent(custEvent);
  }
}