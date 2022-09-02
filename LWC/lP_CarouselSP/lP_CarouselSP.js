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
import { LightningElement, api } from 'lwc';


const CARD_VISIBLE_CLASSES = 'fade slds-show';
const CARD_HIDDEN_CLASSES = 'fade slds-hide';

const DOT_VISIBLE_CLASSES = 'dot active';
const DOT_HIDDEN_CLASSES = 'dot';
const DEFAULT_SLIDER_TIMER = 5000;
export default class LP_CarouselSP extends LightningElement {

    slides = [];
    slideIndex = 1;
    @api sliderTimer = DEFAULT_SLIDER_TIMER;
    timer;

    @api
    get slidesData() {
        return this.slides;
    };

    set slidesData(data) {
        this.slides = data.map((item, index) => {
            return index === 0 ? {
                ...item,
                slideIndex: index + 1,
                cardClasses: CARD_VISIBLE_CLASSES,
                dotClases: DOT_VISIBLE_CLASSES
            } : {
                ...item,
                slideIndex: index + 1,
                cardClasses: CARD_HIDDEN_CLASSES,
                dotClases: DOT_HIDDEN_CLASSES
            }
        });
    }

    currentSlide(event) {
        let slideIndex = Number(event.target.dataset.id);
        this.slideSelectionHandler(slideIndex);
    }

    backSlide() {
        let slideIndex = this.slideIndex - 1;
        this.slideSelectionHandler(slideIndex);
    }

    forwardSlide() {
        let slideIndex = this.slideIndex + 1;
        this.slideSelectionHandler(slideIndex);
    }

    slideSelectionHandler(id) {
        if (id > this.slides.length) {
            this.slideIndex = 1;
        } else if (id < 1) {
            this.slideIndex = this.slides.length;
        } else {
            this.slideIndex = id;
        }

        this.slides = this.slides.map(item => {
            return this.slideIndex === item.slideIndex ? {
                ...item,
                cardClasses: CARD_VISIBLE_CLASSES,
                dotClases: DOT_VISIBLE_CLASSES
            } : {
                ...item,
                cardClasses: CARD_HIDDEN_CLASSES,
                dotClases: DOT_HIDDEN_CLASSES
            }

        });

    }
 
    connectedCallback() {

        this.timer = window.setInterval(() => {
            this.slideSelectionHandler(this.slideIndex + 1);
        }, Number(this.sliderTimer))

    }

    disconnectedCallback(){
        window.clearInterval(this.timer);
    }
}