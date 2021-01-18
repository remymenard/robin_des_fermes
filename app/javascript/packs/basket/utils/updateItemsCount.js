export function updateItemsCount() {
  const itemsCount = $('#items-count').data('count');
  $('.items-number').text(itemsCount);
  if(itemsCount === 0) {
    $('.items-number').addClass('d-none');
  } else {
    $('.items-number').removeClass('d-none');
  }
}
