var box = require('custombox');

$(() => {
  $('#navbarDropdown').on('click', (e) => {

    // Instantiate new modal
    var modal = new box.modal({
      content: {
        speedIn: 120,
        speedOut: 120,
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

  $('#cross').on('click', () => {
    box.modal.close();
  })
});
