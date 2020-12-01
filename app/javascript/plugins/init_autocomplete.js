import places from 'places.js';

const initAutocomplete = () => {
  var placesAutocomplete = places({
    appId: 'plCLTVBE3BBD',
    apiKey: 'b3bb8a6ae501e7398a12163dd4a75d9d',
    container: document.querySelector('#user_address'),
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
    document.querySelector('#user_code_postal').value = e.suggestion.postcode || '';
  });
};

export { initAutocomplete };
