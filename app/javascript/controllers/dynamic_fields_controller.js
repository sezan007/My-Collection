import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fields"]

  addField(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.fieldsTarget.insertAdjacentHTML('beforeend', content)
  }

  removeField(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = "none"
  }
}
