import 'jquery';
import "./shared-config";
import Inputmask from "inputmask";

document.addEventListener("DOMContentLoaded", function () {
  const phoneInput = document.querySelector(".js-mask-phone");

  if (phoneInput) {
    $(document).ready(function() {
      const im_phone = new Inputmask("99 99999-9999");
      im_phone.mask(phoneInput);
    });
  }
});
