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
import { LightningElement,track,api } from 'lwc';

export default class LP_PaymentPageSP extends LightningElement {

@track urlparameter;
@track tokenparameter;

renderedCallback(){
    
    var query = window.location.search.substring(1);
    var vars = query;
    var pair1 = vars.split("=");
    var url = pair1[1].split("&")[0];
    var token = pair1[2]

    this.urlparameter = decodeURIComponent(url);
    this.tokenparameter = token;



    this.template.querySelector('form').submit();
}




}