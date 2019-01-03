window.onload = () => {
  $('.locale-btn').on('ajax:complete', () => {
    location.reload();
  });
}
