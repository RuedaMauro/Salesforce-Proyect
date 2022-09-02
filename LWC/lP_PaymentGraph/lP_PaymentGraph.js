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
import {LightningElement,api,track} from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';
import getData from '@salesforce/apex/LP_PaymentController.getMyCardData';

export default class LP_PaymentGraph extends LightningElement {
    @api highestAmount = 0;
    @api totalAmount = 0;
    @api isMobile = FORM_FACTOR === 'Small';
    todayMonth;
    todayYear;
    todayMonthLetters = '';

    @track dataHard = [{
            amount: 0,
            percentageValue: 0,
            month: 'Mar 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Abr 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'May 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Jun 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Jul 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Ago 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Sep 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Oct 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Nov 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Dic 2021',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Ene 2022',
            date: '',
        },
        {
            amount: 0,
            percentageValue: 0,
            month: 'Feb 2022',
            date: '',
        }
    ]
    connectedCallback() {
        var a = new Date();
        var b = new Date();
        this.todayMonth = a.getMonth();
        this.todayYear = b.getFullYear();
        this.todayMonth = this.todayMonth - 1;

        var j;
        for (j = 0; j < this.dataHard.length; j++) {
            if (this.todayMonth < 0) {
                this.todayMonth = 11;
                this.todayYear = this.todayYear - 1;
            }
            this.dataHard[j].date = this.todayMonth + '/' + this.todayYear;
            if (this.todayMonth == 0) this.todayMonthLetters = 'Ene';
            if (this.todayMonth == 1) this.todayMonthLetters = 'Feb';
            if (this.todayMonth == 2) this.todayMonthLetters = 'Mar';
            if (this.todayMonth == 3) this.todayMonthLetters = 'Abr';
            if (this.todayMonth == 4) this.todayMonthLetters = 'May';
            if (this.todayMonth == 5) this.todayMonthLetters = 'Jun';
            if (this.todayMonth == 6) this.todayMonthLetters = 'Jul';
            if (this.todayMonth == 7) this.todayMonthLetters = 'Ago';
            if (this.todayMonth == 8) this.todayMonthLetters = 'Sep';
            if (this.todayMonth == 9) this.todayMonthLetters = 'Oct';
            if (this.todayMonth == 10) this.todayMonthLetters = 'Nov';
            if (this.todayMonth == 11) this.todayMonthLetters = 'Dic';
            this.dataHard[j].month = this.todayMonthLetters + ' ' + this.todayYear;
            this.todayMonth = this.todayMonth - 1;
        }

        /**
         * @Description: Gets the data needed for the graph. 
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

                var k;
                for (k = 0; k < result.paymentHistory.length; k++) {
                    var c;
                    for (c = 0; c < this.dataHard.length; c++) {
                        if (this.dataHard[c].date.length == 6) {
                            this.dataHard[c].date = '0' + this.dataHard[c].date;
                        }
                        var parser0 = result.paymentHistory[k].fecom.slice(3, 5);
                        var parser = parseInt(parser0) - 1;
                        if (parser < 10) {
                            var parser2 = '0' + parser.toString() + result.paymentHistory[k].fecom.slice(-5);
                        } else {
                            var parser2 = parser.toString() + result.paymentHistory[k].fecom.slice(-5);
                        }
                        if (this.dataHard[c].date == parser2) {
                            this.dataHard[c].amount = this.dataHard[c].amount + result.paymentHistory[k].monto;
                        }
                    }

                }
                if (this.isMobile == false) {
                    var i;
                    for (i = 0; i < this.dataHard.length; i++) {
                        if (this.dataHard[i].amount > this.highestAmount) {
                            this.highestAmount = this.dataHard[i].amount;
                        }
                        this.totalAmount = this.totalAmount + this.dataHard[i].amount;
                    }
                    for (i = 0; i < this.dataHard.length; i++) {
                        if (this.dataHard[i].amount == 0) {
                            this.dataHard[i].percentageValue = 0;
                        } else {
                            this.dataHard[i].percentageValue = (this.dataHard[i].amount / this.highestAmount) * 100;
                        }
                    }
                    this.totalAmount = new Intl.NumberFormat('de-DE').format(this.totalAmount);
                }

                if (this.isMobile == true) {
                    var i;
                    for (i = 0; i < this.dataHard.length; i++) {
                        if (this.dataHard[i].amount > this.highestAmount) {
                            this.highestAmount = this.dataHard[i].amount;
                        }
                        this.totalAmount = this.totalAmount + this.dataHard[i].amount;
                    }
                    for (i = 0; i < this.dataHard.length / 2; i++) {
                        if (this.dataHard[i].amount == 0) {
                            this.dataHard[i].percentageValue = 0;
                        } else {
                            this.dataHard[i].percentageValue = (this.dataHard[i].amount / this.highestAmount) * 100;
                        }
                    }
                    this.totalAmount = new Intl.NumberFormat('de-DE').format(this.totalAmount);
                }

            }).catch(err => this.error(err)));


    }

    setBackground = () => new Promise(resolve => resolve("success"));
    get widthPercentage() {
        return 'height:' + this.dataHard[11].percentageValue + '%';
    }
    get widthPercentage1() {
        return 'height:' + this.dataHard[10].percentageValue + '%';
    }
    get widthPercentage2() {
        return 'height:' + this.dataHard[9].percentageValue + '%';
    }
    get widthPercentage3() {
        return 'height:' + this.dataHard[8].percentageValue + '%';
    }
    get widthPercentage4() {
        return 'height:' + this.dataHard[7].percentageValue + '%';
    }
    get widthPercentage5() {
        return 'height:' + this.dataHard[6].percentageValue + '%';
    }
    get widthPercentage6() {
        return 'height:' + this.dataHard[5].percentageValue + '%';
    }
    get widthPercentage7() {
        return 'height:' + this.dataHard[4].percentageValue + '%';
    }
    get widthPercentage8() {
        return 'height:' + this.dataHard[3].percentageValue + '%';
    }
    get widthPercentage9() {
        return 'height:' + this.dataHard[2].percentageValue + '%';
    }
    get widthPercentage10() {
        return 'height:' + this.dataHard[1].percentageValue + '%';
    }
    get widthPercentage11() {
        return 'height:' + this.dataHard[0].percentageValue + '%';
    }

    get monthYear() {
        return this.dataHard[11].month;
    }
    get monthYear1() {
        return this.dataHard[10].month;
    }
    get monthYear2() {
        return this.dataHard[9].month;
    }
    get monthYear3() {
        return this.dataHard[8].month;
    }
    get monthYear4() {
        return this.dataHard[7].month;
    }
    get monthYear5() {
        return this.dataHard[6].month;
    }
    get monthYear6() {
        return this.dataHard[5].month;
    }
    get monthYear7() {
        return this.dataHard[4].month;
    }
    get monthYear8() {
        return this.dataHard[3].month;
    }
    get monthYear9() {
        return this.dataHard[2].month;
    }
    get monthYear10() {
        return this.dataHard[1].month;
    }
    get monthYear11() {
        return this.dataHard[0].month;
    }

    get amountGetter() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[11].amount);
    }
    get amountGetter1() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[10].amount);
    }
    get amountGetter2() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[9].amount);
    }
    get amountGetter3() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[8].amount);
    }
    get amountGetter4() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[7].amount);
    }
    get amountGetter5() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[6].amount);
    }
    get amountGetter6() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[5].amount);
    }
    get amountGetter7() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[4].amount);
    }
    get amountGetter8() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[3].amount);
    }
    get amountGetter9() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[2].amount);
    }
    get amountGetter10() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[1].amount);
    }
    get amountGetter11() {
        return '$ ' + new Intl.NumberFormat('de-DE').format(this.dataHard[0].amount);
    }
}