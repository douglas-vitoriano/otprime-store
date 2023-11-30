import 'inputmask/dist/jquery.inputmask';

document.addEventListener("turbolinks:load", function() {
  $(":password").inputmask({   
    regex: String.raw`^[\w@#$%\^&\*\(\)_\+\-=\[\]\{\};:'",<>\./\\?]+`,
    placeholder: '',
  });
});
