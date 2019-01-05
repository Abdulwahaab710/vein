$(document).ready(() => {
  if ($('#user_city').length === 1) {
    $('#user_city').change(() => {
      let city = $('#user_city :selected').val();
      $.ajax({
        url: `/cities/${city}`,
        success: function(response){
          let select = $('select#districts')
          select.empty();
          option = new Option("", "", true, true);
          select.append(option);
          for (var i=0;i<response.length;i++){
            option = new Option(response[i]['name'], response[i]['id']);
            select.append(option);
          }
        },
        error: function(){
          UIkit.notification({message: '<span uk-icon=\'icon: close\'></span> Something went wrong!', pos: 'bottom-center', status: 'danger'})
        }
      });
    })
  }
});
