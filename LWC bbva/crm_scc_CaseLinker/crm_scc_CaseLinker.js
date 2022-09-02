import { LightningElement, track, wire } from "lwc"
import { CloseActionScreenEvent } from "lightning/actions"
import { CurrentPageReference } from "lightning/navigation"
import { refreshApex } from "@salesforce/apex"
import getRelatedCases from "@salesforce/apex/CRM_CaseLinkerController.getRelatedCases"
import linkCases from "@salesforce/apex/CRM_CaseLinkerController.linkCases"

const columns = [
  { label: "Número de caso", fieldName: "caseNumber" },
  { label: "Contacto", fieldName: "contactName" },
  {
    label: "Asunto",
    fieldName: "subject"
  },
  {
    label: "Fecha de creación",
    fieldName: "createdDate",
    type: "date",
    typeAttributes: {
      year: "numeric",
      month: "numeric",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    }
  }
]

export default class Crm_scc_caseLinker extends LightningElement {
  recordId
  columns = columns
  rows = []
  selectedRecords = []
  relatedCaseError
  linkCasesError
  @track disableSubmit = true

  _wiredRelatedCases
  @wire(getRelatedCases, { caseId: "$recordId" })
  wiredRelatedCases(wiredResult) {
    const { error, data } = wiredResult
    this._wiredRelatedCases = wiredResult

    if (data) {
      this.setRows(data.notLinkedCases)
    } else if (error) {
      this.relatedCaseError = error
    }
  }

  @wire(CurrentPageReference)
  getStateParameters(currentPageReference) {
    if (currentPageReference) {
      this.recordId = currentPageReference.state.recordId
    }
  }

  setRows(records) {
    this.rows = records.map(({ caseId, caseNumber, subject, createdDate }) => ({
      caseId,
      caseNumber,
      subject,
      createdDate
    }))
  }

  getSelectedRows(event) {
    const selectedRows = event.detail.selectedRows

    this.selectedRecords = Array.from(selectedRows)
    this.disableSubmit = selectedRows.length > 0 ? false : true
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent())
  }

  handleSubmit() {
    const selectedRecords = {
      notLinkedCases: this.selectedRecords
    }

    linkCases({
      casesToLink: JSON.stringify(selectedRecords),
      caseId: this.recordId
    })
      .then(() => {
        refreshApex(this._wiredRelatedCases)
      })
      .catch((err) => {
        this.linkCasesError = err
      })

    this.dispatchEvent(new CloseActionScreenEvent())
  }
}
