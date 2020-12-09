import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '80px';
    element.style.height = '65px';

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
  });
}

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
    });

    const nearbyFarmsMarkers = JSON.parse(mapElement.dataset.nearbyFarmsMarkers);
    const farFarmsMarkers    = JSON.parse(mapElement.dataset.farFarmsMarkers);

    addMarkersToMap(map, nearbyFarmsMarkers);
    addMarkersToMap(map, farFarmsMarkers);

    if (nearbyFarmsMarkers === undefined || nearbyFarmsMarkers.length == 0) {
      fitMapToMarkers(map, farFarmsMarkers)
    } else {
      fitMapToMarkers(map, nearbyFarmsMarkers)
    }


  }
};

export { initMapbox };
