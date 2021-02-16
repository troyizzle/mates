import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["menu"];

    connect() {}

    openMenu(e) {
        e.preventDefault();
        this.menuTarget.hidden = this.isMenuOpen() == true ? false : true;
    }

    isMenuOpen() {
        return this.menuTarget.hasAttribute("hidden");
    }

    toggleTheme() {

    }
}
