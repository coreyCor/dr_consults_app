import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { interval: Number }

  connect() {
    this.timer = setInterval(() => {
      this.element.reload?.()
    }, this.intervalValue || 10000)
  }

  disconnect() {
    clearInterval(this.timer)
  }
}
