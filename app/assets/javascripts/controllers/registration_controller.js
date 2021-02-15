import { Controller } from "stimulus"

const showImage = (input) => {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
          document.getElementById("avatarImg").src = e.target.result
      };

      reader.readAsDataURL(input.files[0]);
    }
}

export default class extends Controller {
    static targets = ["avatar"];

    updateAvatar(event) {
        showImage(event.target, this.avatarTarget);
    }
}
