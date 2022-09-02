import { api, LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getCaseWithChilds from '@salesforce/apex/CRM_CaseHierarchyController.getCaseWithChilds';
import getParentIdIfExists from '@salesforce/apex/CRM_CaseHierarchyController.getParentIdIfExists';
import LOCALE from '@salesforce/i18n/locale';
import TIMEZONE from '@salesforce/i18n/timeZone';

const USER_INFO = Object.freeze({
    LOCALE: LOCALE,
    TIME_ZONE: TIMEZONE
})

const parentPrimaryFields = ['CaseNumber', 'CRM_AreaInterna__c', 'CRM_SCC_ImportantCustomerEmoji__c']
const parentSecondaryFields = ['CreatedDate', 'CRM_SCC_ProductAndService__c', 'CRM_SCC_ContactReason__c', 'Status', 'CRM_ClientFormula__c', 'CRM_SCC_LastComment__c', 'CRM_SCC_LastCommentDate__c']
const childPrimaryFields = ['CaseNumber', 'CRM_AreaInterna__c', 'CRM_SCC_EntitlementStatus__c']
const childSecondaryFields = ['CreatedDate', 'Status', 'CRM_SCC_LastComment__c', 'CRM_SCC_LastCommentDate__c']

//Date fields that need UTC offset fix
const dateFieldsToConvert = ['CreatedDate', 'CRM_SCC_LastCommentDate__c']


export default class crm_CaseHierarchy extends NavigationMixin(LightningElement) {
    @api recordId
    @track isExpanded = false

    parent = {
        primaryFields: [],
        secondaryFields: []
    }

    childs = []


    connectedCallback() {
        let currentRecordId = this.recordId

        getParentIdIfExists({ childId: this.recordId }).then(parentId => {
            if (parentId) {
                currentRecordId = parentId
            }

            getCaseWithChilds({ recordId: currentRecordId }).then(caseData => {
                this.prepareData(caseData);
            })
        })

    }

    prepareData(data) {
        let { parentRecord, childRecords } = data

        this.setParentFields(parentRecord)
        this.setChildFields(childRecords)
    }

    setParentFields(parentRecord) {
        this.parent.id = this.getObjectByKey('Id', parentRecord).value
        this.parent.primaryFields = parentRecord.fields.filter(field => (parentPrimaryFields.includes(field.developername)))
        this.parent.secondaryFields = parentRecord.fields.filter(field => {
            if(dateFieldsToConvert.includes(field.developername)){
                field.value = this.formatDateToUserTimeZone(field.value)
            }
            return parentSecondaryFields.includes(field.developername)
        })
    }

    setChildFields(childRecords) {
        this.childs = childRecords ? this.prepareChildFields(childRecords) : []
    }

    prepareChildFields(childRecords) {
        return childRecords.map(record => {
            return ({
                id: record.fields.find(field => field.developername === 'Id').value,
                primaryFields: record.fields.filter(primaryField => (childPrimaryFields.includes(primaryField.developername))),
                secondaryFields: record.fields.filter(secondaryField => {
                    if(dateFieldsToConvert.includes(secondaryField.developername)){
                        secondaryField.value = this.formatDateToUserTimeZone(secondaryField.value)
                    }

                    return childSecondaryFields.includes(secondaryField.developername)
                })
            })
        })
    }

    handleExpand() {
        this.isExpanded = !this.isExpanded
    }

    handleItemClick(e) {
        let recordId = e.currentTarget.dataset.id
        this.navigateTo(recordId)
    }

    getObjectByKey(key, object) {
        return object.fields.find(field => field.developername === key)
    }

    formatDateToUserTimeZone(givenDate){
        let parsedDate = new Date(givenDate)
        let minutesDiff = parsedDate.getMinutes() - parsedDate.getTimezoneOffset()

        parsedDate.setMinutes(minutesDiff)

        return new Intl.DateTimeFormat(USER_INFO.LOCALE, {
            hourCycle: 'h24',
            dateStyle: 'short',
            timeStyle: 'medium',
            timeZone: USER_INFO.TIME_ZONE
        }).format(parsedDate)
    }

    navigateTo(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Case',
                actionName: 'view'
            }
        });
    }
}