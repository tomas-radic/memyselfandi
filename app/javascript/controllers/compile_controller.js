import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["key"]

  submit() {
    const key = window.prompt("Compile key")
    if (key === null) return
    this.keyTarget.value = key
    this.element.requestSubmit()
  }
}
