import { LightningElement,api,track } from 'lwc';
import getData from '@salesforce/apex/LP_MyAccountController.getMyAccountDataFacturation';
import LP_MsjProxVencimientosMC from '@salesforce/label/c.LP_MsjProxVencimientosMC'
export default class LP_UpcomingMaturities extends LightningElement {
    errors=false;
    @api errorsText='No se presentan próximos vencimientos';
    
    iconProx = {
        LP_MsjProxVencimientosMC

    }
    connectedCallback() {

        this.mets();
        
} 

async mets(){


    this.setBackground().then(() =>
    getData()
        .then((result) => {

            if (result.loginOK==false) {
                this.errorsText='En este momento no es posible entregarte la información de tus movimientos, por favor volver a intentar más tarde'
                this.errors=true;
            }
            if(result.facturationItems[0]==null){
                this.errors=true;
            }
            var i;
            for(i=0;i<result.facturationItems.length;i++){

                this.dataHard[i].date=result.facturationItems[i].fechav;
                this.dataHard[i].amount=new Intl.NumberFormat('de-DE').format(result.facturationItems[i].montov);
            }
            if(result.facturationItems.length<6){
                var j;
                var limit=i;
                for(j=0;j<6-limit;j++){
                    var one=this.dataHard[i-1].date.slice(0,2);
               
                    var two=this.dataHard[i-1].date.slice(3,5);
                  
                    if(parseInt(two)<12){
                        var alt1=parseInt(two);
                        alt1=alt1+1;
                        console.log(alt1);
                        if(alt1<10){
                        two='0'+alt1.toString();
                        }
                        else{
                            two=alt1.toString(); 
                        }
                        console.log(two);
                    }
                    else{
                        two='01';
                    }
                    this.dataHard[i].date=one.concat('/',two);

                    i++;
                }
            }
            
        }).catch(err => this.error(err)));
    
}

setBackground = () => new Promise(resolve => resolve("success"));

    @track dataHard = [{
        id: '0',
        amount: '0',
        date:'',
    },
    {
        id: '1',
        amount: '0',
        date:'',
    },
    {
        id: '2',
        amount: '0',
        date:'',
    },
    {
        id: '3',
        amount: '0',
        date:'',
    },{
        id: '4',
        amount: '0',
        date:'',
    },{
        id: '5',
        amount: '0',
        date:'',
    }]; 
}