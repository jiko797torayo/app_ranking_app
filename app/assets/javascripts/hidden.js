$(function(){
  $(document).on('click', '#fa-sort-down', function() {
    if ($('#ranking-header-link__list').hasClass('hidden')) {
      $('#ranking-header-link__list').removeClass('hidden');
    } else {
      $('#ranking-header-link__list').addClass('hidden');
    }
  });
});
