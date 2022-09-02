/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 21/07/2021
Description : Payment Layout Layout JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 21/07/2021 initial version
********************************************************************************/
import { LightningElement, api, track } from 'lwc';
import flechasSP from '@salesforce/resourceUrl/LP_FlechasADSP';
import getData from '@salesforce/apex/LP_MyAccountController.getMyAccountMovementsData';
import getLastFacturationData from '@salesforce/apex/LP_MyAccountController.getLastFacturationData';
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_UnbilledMovements extends LightningElement {
    @api nextExpiration= "";
    errors=false;
    @api errorsText='No presentas movimientos por facturar';
    @api column;
    @api order='a';
    @api order1='a';
    @api order2='a';
    @api order3='a';
    @api order4='a';
    @api flechas=flechasSP;
    @api isMobile = FORM_FACTOR === 'Small';
    

  @track adataHard = []; 


    connectedCallback() {
      
      /**
      * @Description: Gets data to show unbilled movements.
      * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
      * @Date: 21/07/2021
      */

     this.mets();

     
   
} 

async mets(){


  this.setBackground().then(() =>
  getLastFacturationData()
  .then((result) => {

      if (result.loginOK==false) {
          this.errorsText='En este momento no es posible entregarte la información de tus movimientos, por favor volver a intentar más tarde'
          this.errors=true;
      }
      this.nextExpiration=result.fechaVencimiento;
      
  }).catch(err => this.error(err)));



  this.setBackground().then(() =>
  getData()
  .then((result) => {
      if (result.loginOK==false) {
          this.errorsText='En este momento no es posible entregarte la información de tus movimientos, por favor volver a intentar más tarde'
          this.errors=true;
      }
      if(result.lastMovements[0]==null){
          this.errors=true;
      }
      var i;
      var i = 0;
      var array = [];
      result.lastMovements.forEach(element => {

        var item = {};
        item.monthQuota=new Intl.NumberFormat('de-DE').format(element.valcuota);
          item.date=element.fechacompra;
          item.numberAccount=element.cuotas;
          item.detail=element.descmov;
          item.amountToPay=new Intl.NumberFormat('de-DE').format(element.totcompra);
          i++;
          item.id=i;
          array.push(item);
      });

      this.adataHard = array;
      
  }).catch(err => this.error(err)));


}

setBackground = () => new Promise(resolve => resolve("success"));

      /**
      * @Description: Sorts  values in Chilean Pesos
      * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
      * @Date: 21/07/2021
      */

      sortTable2(){
        var aux,k,i;
        var n=this.adataHard.length;
        if(this.order2=='a'){
          for (k = 1; k < n; k++) {
            for (i = 0; i < (n - k); i++) {
              if (parseInt(this.adataHard[i].amountToPay.replace(/[.]/g, '') )> parseInt(this.adataHard[i+1].amountToPay.replace(/[.]/g, '') )) {
                aux = this.adataHard[i];
                this.adataHard[i] = this.adataHard[i + 1];
                this.adataHard[i + 1] = aux;
              }
            }
          }
        }

        if(this.order2=='d'){
          for (k = 1; k < n; k++) {
            for (i = 0; i < (n - k); i++) {
              if (parseInt(this.adataHard[i].amountToPay.replace(/[.]/g, '') ) < parseInt(this.adataHard[i+1].amountToPay.replace(/[.]/g, '') )) {
                aux = this.adataHard[i];
                this.adataHard[i] = this.adataHard[i + 1];
                this.adataHard[i + 1] = aux;
              }
            }
          }
        }
        if(this.order2=='a'){
         this.order2='d'
        }
        else{
          this.order2='a';
        }

        for(i=0;i<n;i++){
          this.adataHard[i].id=i;
        }  
    }

     /**
      * @Description: Sorts date values. 
      * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
      * @Date: 21/07/2021
      */

    sortTable0(){
      var aux,k,i;
      var n=this.adataHard.length;
      if(this.order=='a'){
        for (k = 1; k < n; k++) {
          for (i = 0; i < (n - k); i++) {
            if (parseInt(this.adataHard[i].date.slice(6,10)) > (parseInt(this.adataHard[i+1].date.slice(6,10)))) {
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            } 
            else if(parseInt(this.adataHard[i].date.slice(6,10)) == (parseInt(this.adataHard[i+1].date.slice(6,10)))&& parseInt(this.adataHard[i].date.slice(3,5)) > (parseInt(this.adataHard[i+1].date.slice(3,5)))){
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            }
            else if(parseInt(this.adataHard[i].date.slice(6,10)) == (parseInt(this.adataHard[i+1].date.slice(6,10)))&& parseInt(this.adataHard[i].date.slice(3,5)) == (parseInt(this.adataHard[i+1].date.slice(3,5)))&&parseInt(this.adataHard[i].date.slice(0,2)) > (parseInt(this.adataHard[i+1].date.slice(0,2)))){
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            }
            
          }
        }
      }

      if(this.order=='d'){
        for (k = 1; k < n; k++) {
          for (i = 0; i < (n - k); i++) {
            if (parseInt(this.adataHard[i].date.slice(6,10)) < (parseInt(this.adataHard[i+1].date.slice(6,10)))) {
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            }
            else if(parseInt(this.adataHard[i].date.slice(6,10)) == (parseInt(this.adataHard[i+1].date.slice(6,10)))&& parseInt(this.adataHard[i].date.slice(3,5)) < (parseInt(this.adataHard[i+1].date.slice(3,5)))){
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            }
            else if(parseInt(this.adataHard[i].date.slice(6,10)) == (parseInt(this.adataHard[i+1].date.slice(6,10)))&& parseInt(this.adataHard[i].date.slice(3,5)) == (parseInt(this.adataHard[i+1].date.slice(3,5)))&&parseInt(this.adataHard[i].date.slice(0,2)) < (parseInt(this.adataHard[i+1].date.slice(0,2)))){
              aux = this.adataHard[i];
              this.adataHard[i] = this.adataHard[i + 1];
              this.adataHard[i + 1] = aux;
            }
          }
        }
      }
      if(this.order=='a'){
       this.order='d'
      }
      else{
        this.order='a';
      }

      for(i=0;i<n;i++){
        this.adataHard[i].id=i;
      }  
  }

    /**
    * @Description: Sorts String values
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 21/07/2021
    */

  sortTable1(){
    var aux,k,i;
    var n=this.adataHard.length;
    if(this.order1=='a'){
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (this.adataHard[i].detail > this.adataHard[i + 1].detail) {
            aux = this.adataHard[i];
            this.adataHard[i] = this.adataHard[i + 1];
            this.adataHard[i + 1] = aux;
          }
        }
      }
    }

    if(this.order1=='d'){
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (this.adataHard[i].detail< this.adataHard[i + 1].detail) {
            aux = this.adataHard[i];
            this.adataHard[i] = this.adataHard[i + 1];
            this.adataHard[i + 1] = aux;
          }
        }
      }
    }
    if(this.order1=='a'){
     this.order1='d'
    }
    else{
      this.order1='a';
    }

    for(i=0;i<n;i++){
      this.adataHard[i].id=i;
    }  
}

    /**
    * @Description: Sorts String values
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 21/07/2021
    */

sortTable3(){
  var aux,k,i;
  var n=this.adataHard.length;
  if(this.order3=='a'){
    for (k = 1; k < n; k++) {
      for (i = 0; i < (n - k); i++) {
        if (this.adataHard[i].numberAccount > this.adataHard[i + 1].numberAccount) {
          aux = this.adataHard[i];
          this.adataHard[i] = this.adataHard[i + 1];
          this.adataHard[i + 1] = aux;
        }
      }
    }
  }

  if(this.order3=='d'){
    for (k = 1; k < n; k++) {
      for (i = 0; i < (n - k); i++) {
        if (this.adataHard[i].numberAccount< this.adataHard[i + 1].numberAccount) {
          aux = this.adataHard[i];
          this.adataHard[i] = this.adataHard[i + 1];
          this.adataHard[i + 1] = aux;
        }
      }
    }
  }
  if(this.order3=='a'){
   this.order3='d'
  }
  else{
    this.order3='a';
  }

  for(i=0;i<n;i++){
    this.adataHard[i].id=i;
  }  
}

    /**
    * @Description: Sorts  values in Chilean Pesos
    * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
    * @Date: 21/07/2021
    */

sortTable4(){
  var aux,k,i;
  var n=this.adataHard.length;
  if(this.order4=='a'){
    for (k = 1; k < n; k++) {
      for (i = 0; i < (n - k); i++) {
        if (parseInt(this.adataHard[i].monthQuota.replace(/[.]/g, '') ) > parseInt(this.adataHard[i+1].monthQuota.replace(/[.]/g, '') )) {
          aux = this.adataHard[i];
          this.adataHard[i] = this.adataHard[i + 1];
          this.adataHard[i + 1] = aux;
        }
      }
    }
  }

  if(this.order4=='d'){
    for (k = 1; k < n; k++) {
      for (i = 0; i < (n - k); i++) {
        if (parseInt(this.adataHard[i].monthQuota.replace(/[.]/g, '') )< parseInt(this.adataHard[i+1].monthQuota.replace(/[.]/g, '') )) {
          aux = this.adataHard[i];
          this.adataHard[i] = this.adataHard[i + 1];
          this.adataHard[i + 1] = aux;
        }
      }
    }
  }
  if(this.order4=='a'){
   this.order4='d'
  }
  else{
    this.order4='a';
  }

  for(i=0;i<n;i++){
    this.adataHard[i].id=i;
  }  
}


}