import places from 'places.js';

const initAutocomplete = () => {
  const input = document.querySelector('#user_address_line_1')

  if (input) {
    var placesAutocomplete = places({
      appId: process.env.ALGOLIA_APP_ID,
      apiKey: process.env.ALGOLIA_API_KEY,
      container: input,
      templates: {
        value: function(suggestion) {
          return suggestion.name;
        }
      }
    }).configure({
      type: 'address'
    });
    placesAutocomplete.on('change', function resultSelected(e) {
      document.querySelector('#user_city').value = e.suggestion.city || '';
      document.querySelector('#user_zip_code').value = e.suggestion.postcode || '';
    });
  }
};


export { initAutocomplete };

