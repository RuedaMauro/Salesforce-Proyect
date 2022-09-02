/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Payment Component
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 14/06/2021 initial version
********************************************************************************/
import {LightningElement,track,api} from 'lwc';
import flechasSP from '@salesforce/resourceUrl/LP_FlechasADSP';
import getData from '@salesforce/apex/LP_PaymentController.getMyCardData';
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_PaymentHistory extends LightningElement {
  @api flechas = flechasSP;
  @api order = 'a';
  @api checkAmount = false;
  @api item = {
    id: '0',
    month: 'Enero',
    store: 'La tiendo Ejemplo',
    date: '17/03/2021',
    amount: '4000',
  }
  @api isMobile = FORM_FACTOR === 'Small';
  @track dataHard = [];

  connectedCallback() {

    /**
     * @Description: Gets the data needed for the payment history table. 
     * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
     * @Date: 14/06/2021
     */

    this.mets();

    
     
  }

  async mets(){


    this.setBackground().then(() =>
    getData()
      .then((result) => {
        
        if (result.loginOK == false) {
          this.errorsText = 'En este momento no es posible entregarte la información de tus movimientos, por favor volver a intentar más tarde'
          this.errors = true;
        }
        if (result.paymentHistory[0] == null) {
          this.errors = true;
        }
        var i;
        if (result.paymentHistory.length >= 10) {
          this.checkAmount = true;
        }
        for (i = 0; i < result.paymentHistory.length; i++) {
          var item2 = {};
          item2.month = result.paymentHistory[i].month;
          item2.amount = new Intl.NumberFormat('de-DE').format(result.paymentHistory[i].monto);
          item2.date = result.paymentHistory[i].fecom;
          item2.store = result.paymentHistory[i].nombre;
          item2.id = i.toString;
          this.dataHard.push(item2);
        }


      }).catch(err => this.error(err)));

  }

  setBackground = () => new Promise(resolve => resolve("success"));

  /**
   * @Description: Sorts the table. 
   * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
   * @Date: 14/06/2021
   */

  sortTable() {
    var aux, k, i;
    var n = this.dataHard.length;
    if (this.order == 'a') {
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (parseInt(this.dataHard[i].date.slice(6, 10)) > (parseInt(this.dataHard[i + 1].date.slice(6, 10)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          } else if (parseInt(this.dataHard[i].date.slice(6, 10)) == (parseInt(this.dataHard[i + 1].date.slice(6, 10))) && parseInt(this.dataHard[i].date.slice(3, 5)) > (parseInt(this.dataHard[i + 1].date.slice(3, 5)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          } else if (parseInt(this.dataHard[i].date.slice(6, 10)) == (parseInt(this.dataHard[i + 1].date.slice(6, 10))) && parseInt(this.dataHard[i].date.slice(3, 5)) == (parseInt(this.dataHard[i + 1].date.slice(3, 5))) && parseInt(this.dataHard[i].date.slice(0, 2)) > (parseInt(this.dataHard[i + 1].date.slice(0, 2)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          }

        }
      }
    }
    if (this.order == 'd') {
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (parseInt(this.dataHard[i].date.slice(6, 10)) < (parseInt(this.dataHard[i + 1].date.slice(6, 10)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          } else if (parseInt(this.dataHard[i].date.slice(6, 10)) == (parseInt(this.dataHard[i + 1].date.slice(6, 10))) && parseInt(this.dataHard[i].date.slice(3, 5)) < (parseInt(this.dataHard[i + 1].date.slice(3, 5)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          } else if (parseInt(this.dataHard[i].date.slice(6, 10)) == (parseInt(this.dataHard[i + 1].date.slice(6, 10))) && parseInt(this.dataHard[i].date.slice(3, 5)) == (parseInt(this.dataHard[i + 1].date.slice(3, 5))) && parseInt(this.dataHard[i].date.slice(0, 2)) < (parseInt(this.dataHard[i + 1].date.slice(0, 2)))) {
            aux = this.dataHard[i];
            this.dataHard[i] = this.dataHard[i + 1];
            this.dataHard[i + 1] = aux;
          }
        }
      }
    }
    if (this.order == 'a') {
      this.order = 'd'
    } else {
      this.order = 'a';
    }

    for (i = 0; i < n; i++) {
      this.dataHard[i].id = i;
    }
  }

}