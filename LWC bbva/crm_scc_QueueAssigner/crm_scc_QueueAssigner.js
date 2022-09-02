import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSocialQueues from '@salesforce/apex/CRM_QueueService.getSocialQueues';
import changeQueueAssignment from '@salesforce/apex/CRM_QueueService.changeQueueAssignment';

export default class crm_scc_QueueAssigner extends LightningElement {
    @track value = [];
    @track error;
    @track socialQueues;
    @track showSpinner = false;

    @wire(getSocialQueues)
    wiredSocialQueues({ error, data }) {
        if (data) {
            this.socialQueues = data
            data.forEach(element => {
                if (element.itBelongs) {
                    this.value = [...this.value, element.queue.Id]
                }
            });
        } else if(error) {
            this.error = error
        }
    }

    // Getters
    get options() {
        if (this.socialQueues) {
            return this.socialQueues.map(element => ({label: element.queue.Name, value: element.queue.Id}))
        }

        return undefined
    }

    get selectedValues() {
        return this.value.join(',');
    }

    // Methods
    handleChange(e) {
        this.value = e.detail.value;
    }

    handleClick() {
        let ownedQueues = this.value,
            notOwnedQueues = this.socialQueues.filter(item => !ownedQueues.includes(item.queue.Id)),
            notOwnedQueueIds = notOwnedQueues.map(item => item.queue.Id)

        this.showSpinner = !this.showSpinner;
        changeQueueAssignment({ ownedQueues, notOwnedQueues:notOwnedQueueIds})
            .then(result => {
                this.showSpinner = !this.showSpinner;
                this.showToast('warning', 'Sus asignaciones han cambiado. Para aplicar cambios, cambie su estado a sin conexión y luego a cualquier estado disponible');
                this.showToast(result.status, result.message);
            })
            .catch()
    }

    showToast(variant, message) {
        const event = new ShowToastEvent({
            variant: variant,
            message: message
        });
        this.dispatchEvent(event);
    }
}