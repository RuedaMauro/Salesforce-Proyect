import { LightningElement, api,track } from 'lwc';
import pagosSP from '@salesforce/resourceUrl/LP_UpagoSP';
import FORM_FACTOR from '@salesforce/client/formFactor';
import getDebtPayment from '@salesforce/apex/LP_PaymentController.getDebtData';
import getBalanceData from '@salesforce/apex/LP_PaymentController.getBalanceData';  
import sendPay from '@salesforce/apex/LP_PaymentController.sendPayRequest';
import LP_PagarCuotaPC from '@salesforce/label/c.LP_PagarCuotaPC'
import LP_MontoPagarPC from '@salesforce/label/c.LP_MontoPagarPC'
import LP_PagaroAbonarPC from '@salesforce/label/c.LP_PagaroAbonarPC'
import LP_ComprobantePagosPC from '@salesforce/label/c.LP_ComprobantePagosPC'

export default class LP_PaymentComponent extends LightningElement {
    isError=false;
    isError2=false;
    @api showComponent=false;
    @api errors;
    @api errors2;
    @track amount="0";
    @api email='';
    @api debtTotal;
    @track string ="0";
    @track amountToShow = "0";
    @api debtTotalView;
    @api debtBilled;
    @api validationRule='([0-9])*';
    @api validationRule2=/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    amountValidation=true;
    @api templateSP;
    @api pagos=pagosSP;
    @api modal=false;
    @api urlparameter = '';
    @api tokenparameter='';
    @api isMobile = FORM_FACTOR === 'Small';

    iconPay ={
        LP_PagarCuotaPC,
        LP_MontoPagarPC,
        LP_PagaroAbonarPC,
        LP_ComprobantePagosPC

     }
    renderedCallback(){
       this.templateSP = this.template.querySelector('form')
    }
    
    connectedCallback() {

        this.mets();

       
    }

    async mets(){


        this.setBackground().then(() =>
        getDebtPayment()
        .then((result) => {
           

            if (result.loginOK == false) {
               
            }
            else{
                this.debtBilled=parseInt(result.facturada);
                this.debtTotalView=new Intl.NumberFormat('de-DE').format(this.debtBilled);
                this.amount=this.debtBilled;
                this.amount = this.amount.toString().replaceAll(/[.]/g,""); 
                this.amountToShow ='$'+new Intl.NumberFormat('de-DE').format(this.amount);
                this.showComponent=true;
            }

        }).catch(err => this.error(err)));


        this.setBackground().then(() =>
        getBalanceData()
        .then((result) => {
           

            if (result.loginOK == false) {
               
            }
            else{
                this.debtTotal=parseInt(result.utilcompra);
                this.showComponent=true;
            }

        }).catch(err => this.error(err)));

    }

    setBackground = () => new Promise(resolve => resolve("success"));

    handleAmount(event){
        var a =/^[0-9]*$/;
        this.amount = event.target.value.toString().replaceAll(/[.$]/g,""); 
        var b=a.test(this.amount);
        console.log(this.amount);
        console.log('b es'+b);
        if(b!=false){
        this.amountToShow =  '$'+ new Intl.NumberFormat('de-DE').format(this.amount);
        }
        else{
        }
        
        this.isError=false;
        this.isError2=false;
     }

     handleEmail(event){
        this.email = event.target.value;
        this.isError=false;
        this.isError2=false;
     }
    
     pay(){
         var r= new RegExp('^[0-9]+$');
         var r2= new RegExp(/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i);
        if(this.amount=='undefined'||this.amount==0||this.amount==''){
            this.isError=true;
            this.errors='Debes ingresar un monto mayor a $0';
        }
        else if(this.amount<=0){
            this.isError=true;
            this.errors='Debes ingresar un monto mayor a $0';
        } else if(!r.test(this.amount)){
            this.isError=true;
            this.errors='Debes ingresar un monto mayor a $0';
        }
        else if(parseInt(this.amount)>this.debtTotal){
            this.isError=true;
            this.errors='No puedes ingresar un monto mayor que tu cupo utilizado';
        }


        if(this.email=='undefined'||this.email==''){
            this.isError2=true;
            this.errors2='Debes ingresar un correo válido';
        } 
        else if(!r2.test(this.email)){
            this.isError2=true;
            this.errors2='Debes ingresar un correo válido';
        }

        if(this.isError==false&&this.isError2==false){
            this.openModal();
        }
    }

    openModal(){
        this.modal = true;
    }

    closeModal(){
        this.modal = false;
    }


     handlePayment(){
        sendPay ({email:this.email,amount:this.amount})
        .then((result) => {


            if (result.loginOK == true) {
                this.urlparameter = result.URL;
                this.tokenparameter = result.token;
                var url_safe_url = encodeURIComponent(this.urlparameter);
                var url_safe_token = encodeURIComponent(this.tokenparameter);
                var url = "paynow?cid=" + url_safe_url + "&pwd=" + url_safe_token;
                window.open(url,"_blank");
                this.closeModal();

            }

        })
     }

       
}