/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 26/04/2021
Description  : Javascript - Credit Card Path
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			26/04/2021		initial version
********************************************************************************/

import { LightningElement, wire, api, track } from 'lwc';
import getPath from '@salesforce/apex/LP_OnboardingStepOneController.getPath';
import GETPATHUTILITY from '@salesforce/resourceUrl/LP_PathUtility';
import GETUTILITY from '@salesforce/resourceUrl/LP_OnboardingUtility';
import { loadScript } from 'lightning/platformResourceLoader';

export default class LP_CreditCardPath extends LightningElement {
    @track steps = [];
    @api CONSTANT;
    @api objMap;

    /**
    *  @Description: load static resource with constant variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    renderedCallback() {
        loadScript(this, GETPATHUTILITY)
        .then(() => console.log('Loaded GETPATHUTILITY'))
        .catch(error => console.log('error: ' + JSON.stringify(error)));

        loadScript(this, GETUTILITY)
        .then(() => console.log('Loaded GETUTILITY'))
        .catch(error => console.log('error: ' + JSON.stringify(error)));

        this.getValuesPath();
    }

    /**
    *  @Description: Initialize all variables in lightning web component
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    getValuesPath() {
        getPath()
            .then(result => {
                this.CONSTANT = window.jsConstantPath();
                this.objMap = window.jsMapStatus();
                var path = JSON.parse(JSON.stringify(result));
                if(this.steps == null || this.steps.length == 0){
                    for (let i = 0; i < path.length; i++) {
                        path[i].classList = this.objMap[path[i].status].css;
                        this.steps.push(path[i]);
                    }
                }
        }).catch(error => {
                console.log("Eror getCreditCardPath");
        });
    }

    /**
    *  @Description: Method invoked by the parent to mark the path step
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    @api
    onStepSelected(stepSelected) {
        let objStep;
        objStep = (this.steps.find( ({ value }) => value === stepSelected ));
        for (let i = 0; i < this.steps.length; i++) {
            if (this.steps[i].value == objStep.value) {
                this.steps[i].status = this.CONSTANT.STATUS_CURRENT;
                this.steps[i].classList = this.objMap[this.CONSTANT.STATUS_CURRENT].css;
                this.steps[i].tabIndex = this.objMap[this.CONSTANT.STATUS_CURRENT].tabIndex;
                this.steps[i].selected = this.objMap[this.CONSTANT.STATUS_CURRENT].selected;
            } else if (i < objStep.order) {
                this.steps[i].status = this.CONSTANT.STATUS_COMPLETE;
                this.steps[i].classList = this.objMap[this.CONSTANT.STATUS_COMPLETE].css;
                this.steps[i].tabIndex = this.objMap[this.CONSTANT.STATUS_COMPLETE].tabIndex;
                this.steps[i].selected = this.objMap[this.CONSTANT.STATUS_COMPLETE].selected;
            } else if (i > objStep.order) {
                this.steps[i].status = this.CONSTANT.STATUS_INCOMPLETE;
                this.steps[i].classList = this.objMap[this.CONSTANT.STATUS_INCOMPLETE].css;
                this.steps[i].tabIndex = this.objMap[this.CONSTANT.STATUS_INCOMPLETE].tabIndex;
                this.steps[i].selected = this.objMap[this.CONSTANT.STATUS_INCOMPLETE].selected;
            }
        }
    }
}