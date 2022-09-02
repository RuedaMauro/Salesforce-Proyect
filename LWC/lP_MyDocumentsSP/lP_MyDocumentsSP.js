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
import { LightningElement,api,track } from 'lwc';
import LP_DocumentsFilesSP from '@salesforce/resourceUrl/LP_DocumentsFilesSP';
import LP_DownloadFilesSP from '@salesforce/resourceUrl/LP_DownloadFilesSP';
import getSignedDocuments from '@salesforce/apex/LP_DocumentController.getDocumentList';
import getDocumentLink from '@salesforce/apex/LP_DocumentController.getDocumentLink'; 
import LP_MisDocumentosMP from '@salesforce/label/c.LP_MisDocumentosMP'
import LP_DocImportantesMP from '@salesforce/label/c.LP_DocImportantesMP'
import LP_OrdenarNombreMP from '@salesforce/label/c.LP_OrdenarNombreMP'
import LP_OrdenarFechaMP from '@salesforce/label/c.LP_OrdenarFechaMP'
import FORM_FACTOR from '@salesforce/client/formFactor';


export default class LP_MyDocumentsSP extends LightningElement {



    @track data = [];
    @api isMobile = FORM_FACTOR === 'Small';
    @track dataArray;

    @api order='a';
    @api order1='a';

    icons={LP_DocumentsFilesSP,
        LP_DownloadFilesSP,
        LP_MisDocumentosMP,
        LP_DocImportantesMP,
        LP_OrdenarNombreMP,
        LP_OrdenarFechaMP};


    connectedCallback(){

        /**
      * @Description: Gets client documents.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 11/08/2021
      */

        this.mets();

        
              
    }

    async mets(){

      this.setBackground().then(() =>
      getSignedDocuments()
      .then( result => {

        console.log(JSON.stringify(result));
          
          if(result.loginOK==true){

              var list = [];
             

              this.dataArray = result.signedDocuments;

              this.dataArray.forEach(element => {

                var array = {};
                var year = element.docdate.slice(0,4);
                var month = element.docdate.slice(4,6);
                var day = element.docdate.slice(6,8);

                array.download = element.id;
                array.nombre = element.name;
                array.fecha = year + "-" + month + "-" + day;
                array.link = element.link;

                list.push(array);

              });

              this.data = list;
              
          }      
      })
      .catch(error =>{
        console.log(JSON.stringify(error));
      }).catch(err => this.error(err)));

    }

    setBackground = () => new Promise(resolve => resolve("success"));

    openDocument(event){

      var link;

      console.log(event.target.dataset.item);

      
      getDocumentLink({ code: event.target.dataset.item})
                .then( result => {

                  console.log(JSON.stringify(result));
                    
                    
                      link = result; 
                      window.open(link,"_blank");
                        
                         
                }); 

  
     
    }

      /**
      * @Description: Sorts document table by words.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 11/08/2021
      */

    sortTable0(){
      var aux,k,i;
      var n=this.data.length;
      if(this.order=='a'){
        for (k = 1; k < n; k++) {
          for (i = 0; i < (n - k); i++) {
            if (parseInt(this.data[i].fecha.slice(6,10)) > (parseInt(this.data[i+1].fecha.slice(6,10)))) {
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
            } 
            else if(parseInt(this.data[i].fecha.slice(6,10)) == (parseInt(this.data[i+1].fecha.slice(6,10)))&& parseInt(this.data[i].fecha.slice(3,5)) > (parseInt(this.data[i+1].fecha.slice(3,5)))){
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
            }
            else if(parseInt(this.data[i].fecha.slice(6,10)) == (parseInt(this.data[i+1].fecha.slice(6,10)))&& parseInt(this.data[i].fecha.slice(3,5)) == (parseInt(this.data[i+1].fecha.slice(3,5)))&&parseInt(this.data[i].fecha.slice(0,2)) > (parseInt(this.data[i+1].fecha.slice(0,2)))){
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
            }
            
          }
        }
      }

      if(this.order=='d'){
        for (k = 1; k < n; k++) {
          for (i = 0; i < (n - k); i++) {
            if (parseInt(this.data[i].fecha.slice(6,10)) < (parseInt(this.data[i+1].fecha.slice(6,10)))) {
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
            }
            else if(parseInt(this.data[i].fecha.slice(6,10)) == (parseInt(this.data[i+1].fecha.slice(6,10)))&& parseInt(this.data[i].fecha.slice(3,5)) < (parseInt(this.data[i+1].fecha.slice(3,5)))){
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
            }
            else if(parseInt(this.data[i].fecha.slice(6,10)) == (parseInt(this.data[i+1].fecha.slice(6,10)))&& parseInt(this.data[i].fecha.slice(3,5)) == (parseInt(this.data[i+1].fecha.slice(3,5)))&&parseInt(this.data[i].fecha.slice(0,2)) < (parseInt(this.data[i+1].fecha.slice(0,2)))){
              aux = this.data[i];
              this.data[i] = this.data[i + 1];
              this.data[i + 1] = aux;
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
        this.data[i].id=i;
       
      }  

    }


    sortTable1(){

      
      /**
      * @Description: Sorts document table by numbers.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 11/08/2021
      */


    var aux,k,i;
    var n=this.data.length;
    if(this.order1=='a'){
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (this.data[i].nombre > this.data[i + 1].nombre) {
            aux = this.data[i];
            this.data[i] = this.data[i + 1];
            this.data[i + 1] = aux;
          }
        }
      }
    }

    if(this.order1=='d'){
      for (k = 1; k < n; k++) {
        for (i = 0; i < (n - k); i++) {
          if (this.data[i].nombre< this.data[i + 1].nombre) {
            aux = this.data[i];
            this.data[i] = this.data[i + 1];
            this.data[i + 1] = aux;
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
      this.data[i].id=i;
      
    }  

    }

}