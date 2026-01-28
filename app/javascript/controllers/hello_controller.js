import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    console.log("Stimulus controller connected")
  }

  sayHi() {
    this.messageTarget.textContent = "👋 Hi from Stimulus!"
  }
}
