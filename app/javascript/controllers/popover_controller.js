import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
    const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
  }
}
