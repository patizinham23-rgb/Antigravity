import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateLabels()
  }

  updateLabels() {
    this.element.querySelectorAll("input[type=radio]").forEach((input) => {
      input.addEventListener("change", () => {
        this.element.querySelectorAll("label").forEach((label, i) => {
          const rating = i + 1
          const checked = this.element.querySelector(`#rating_${rating}`)?.checked
          label.style.color = checked ? "#c9a84c" : "#333"
        })
      })
    })
  }
}
