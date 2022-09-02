/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 10/07/2021
Description : My Limit Amount JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
German Luis Basgall GLB
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 GLB 10/07/2021 initial version
********************************************************************************/

import { LightningElement, api,track } from 'lwc';
import getData from '@salesforce/apex/LP_MyAccountController.getMyAccountBalanceData'; 
import LP_ComprasMC from '@salesforce/label/c.LP_ComprasMC'
import LP_AvanceEnEfectivoMC from '@salesforce/label/c.LP_AvanceEnEfectivoMC'
import LP_AvanceXLMC from '@salesforce/label/c.LP_AvanceXLMC'

export default class LP_MyLimitAmount extends LightningElement {
    
    connectedCallback() {
            
            /**
            * @Description: Gets the data for the limit amount Page.
            * @Author: Germán Basgall, Deloitte, gbasgall@deloitte.com
            * @Date: 10/07/2021
            */

            this.mets();
        
    } 

    async mets(){


        this.setBackground().then(() =>
        getData()
            .then((result) => {
                this.dataHard[0].available=new Intl.NumberFormat('de-DE').format(result.dispcompra);
                this.dataHard[0].used=new Intl.NumberFormat('de-DE').format(result.utilcompra);
                this.dataHard[0].total=new Intl.NumberFormat('de-DE').format(result.cupocompras);
                if(result.dispav>0){
                    this.dataHard[1].available=new Intl.NumberFormat('de-DE').format(result.dispav);
                    this.dataHard[1].used=new Intl.NumberFormat('de-DE').format(result.utilpav);
                    this.dataHard[1].total=new Intl.NumberFormat('de-DE').format(result.cupoavance);
                }
                else{
                    this.dataHard[1].available='0';
                    this.dataHard[1].used='0';
                    this.dataHard[1].total='0';
                }
                if(result.dispavxl>0){
                    this.dataHard[2].available=new Intl.NumberFormat('de-DE').format(result.dispavxl);
                    this.dataHard[2].used=new Intl.NumberFormat('de-DE').format(result.utilavxl);
                    this.dataHard[2].total=new Intl.NumberFormat('de-DE').format(result.cupoavancexl);
                }
                else{
                    this.dataHard[2].available='0';
                    this.dataHard[2].used='0';
                    this.dataHard[2].total='0';

                }
            }).catch(err => this.error(err)));

    }

    setBackground = () => new Promise(resolve => resolve("success"));
    

      @track dataHard = [{
                        id: 'a',
                        limitAmount: LP_ComprasMC,
                        total: '0',
                        used: '0',
                        available: '0',
                    },
                    {
                        id: 'b',
                        limitAmount: LP_AvanceEnEfectivoMC,
                        total: '0',
                        used: '0',
                        available: '0',
                    },
                    {
                        id: 'c',
                        limitAmount: LP_AvanceXLMC,
                        total: '0',
                        used: '0',
                        available: '0',
                    }
                    ];        
}