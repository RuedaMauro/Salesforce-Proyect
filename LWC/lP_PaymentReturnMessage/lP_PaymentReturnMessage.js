import { LightningElement,api } from 'lwc';
import checkSP from '@salesforce/resourceUrl/LP_CheckCircleWhiteSP';

export default class LP_PaymentReturnMessage extends LightningElement {
    @api check=checkSP;
    @api rut=10068723-3;
    @api cardNumber=55555555;
    @api amountPaid=800;
    @api code=121111111111323;
    @api date='2020-12-15 17:00';
}