import { LightningElement } from 'lwc';
import CMF from '@salesforce/label/c.LP_CMFChile';
import CMFText from '@salesforce/label/c.LP_CMFText';
import LPCard from '@salesforce/label/c.LP_TarjetaLaPolar';	
import LPCardText from '@salesforce/label/c.LP_TarjetaLaPolarText';
import LPCardInfomation from '@salesforce/label/c.LP_CardInformation';

export default class LP_CardInformation extends LightningElement {
    //Custom Label
    label = {
        CMF,
        CMFText,
        LPCard,
        LPCardText,
        LPCardInfomation
    };
}