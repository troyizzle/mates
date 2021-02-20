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

    toggleUserTheme(e) {
        e.preventDefault();

        Rails.ajax({
            type: "post",
            url: e.currentTarget.dataset.url,
            success: function(data) {
                document.getElementsByTagName("HTML")[0].className = data.theme;
                document.getElementById("menu").innerHTML = data.template;
            }
        })
    }
}
