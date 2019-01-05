$(document).ready(() => {
  if ($("input[type='number']").length === 1) {
    $(() => {
      $("input[type='number']").bind('keypress', (e) => {
        var keyCode = (e.which)?e.which:event.keyCode
        return !(keyCode>31 && (keyCode<48 || keyCode>57));
      });
    });
  }
  if ($("input[type='tel']").length === 1) {
    $(() => {
      $("input[type='tel']").bind('keypress', (e) => {
        var keyCode = (e.which)?e.which:event.keyCode
        return !(keyCode>31 && (keyCode<48 || keyCode>57));
      });
    });
  }
});
