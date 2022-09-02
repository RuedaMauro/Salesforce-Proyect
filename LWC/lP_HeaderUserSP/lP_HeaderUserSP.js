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
import { api, LightningElement,track } from 'lwc';

import LogoLP from '@salesforce/resourceUrl/LP_LogoDocSP';
import getInfo from '@salesforce/apex/LP_HomeController.getUserInfo';

import FORM_FACTOR  from '@salesforce/client/formFactor';

export default class LP_HeaderUserSP extends LightningElement {

    logo = LogoLP;
    nombre = '';
    conexion = '';
    showUser = false;
    isMobile = FORM_FACTOR === 'Small';
    @api showbar = false;

    connectedCallback() {

        this.mets();
 
                  
    }

    async mets(){

        this.setBackground().then(() =>
        getInfo()
        .then(result => {

            if (result.name.toLowerCase().indexOf("sitio") == -1 && result.name != '')

        
            {
                this.nombre = result.name;
                if(result.loginOK==false){
                    this.conexion = " ";
                    
                }
                else{

                    var date = new Date(result.lastLoginDate);

                    var day = date.getDate();
                   
                    var month = new Date(date.setMonth(date.getMonth()+1));
                   
                    var hours = date.getHours();
                   
                    var minutes = date.getMinutes();
                    
               
                    this.conexion = day + '/' + this.pad(month.getMonth(),2) + '/' + date.getFullYear() + '; ' + this.pad(hours,2) + ":" + this.pad(minutes,2) + ' hrs';
                    
                }
                this.showUser = true;
            }

        }).catch(err => this.error(err)));

    }

    setBackground = () => new Promise(resolve => resolve("success"));



    pad(num, size){
        num = num.toString();
        while (num.length < size) num = "0" + num;
        return num;
    }


}