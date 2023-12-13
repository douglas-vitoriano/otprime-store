import Inputmask from "inputmask";

// document.addEventListener("turbolinks:load", function() {
//   $(":password").inputmask({   
//     regex: String.raw`^[\w@#$%\^&\*\(\)_\+\-=\[\]\{\};:'",<>\./\\?]+`,
//     placeholder: '',
//   });
// });


$(document).on('turbolinks:load', function() {
  const element_phone = document.getElementsByClassName('mask-phone')
  console.log("Elementos selecionados:", element_phone);

  if (element_phone.length > 0) {
    const im_phone = new Inputmask("(99) 999999999")
    console.log("Inputmask criado:", im_phone);
    im_phone.mask(element_phone);
  }
});
