var box = require('custombox');

$(() => {
  $('#navbarDropdown').on('click', (e) => {

    // Instantiate new modal
    var modal = new box.modal({
      content: {
        speedIn: 100,
        speedOut: 90,
        effect: 'blur',
        target: '#basket',
        positionX: 'right',
        positionY: 'top'
      },
      loader: {
        active: false
      }
    });

    // Open
    modal.open();
    e.preventDefault();
  });

  $('#cross').on('click', (e) => {
    box.modal.close();
    e.preventDefault();
  })
});
