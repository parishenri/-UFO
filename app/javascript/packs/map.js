import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

var mapElement = document.getElementById('map');
let map

if (mapElement) { // don't try to build a map if there's no div#map to inject in
  map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(13);
  } else {
    map.fitLatLngBounds(markers);
  }
}
autocomplete();

  const userIcon = {
    url: document.getElementById('map').dataset.userimage,
    scaledSize: new google.maps.Size(20, 20),
    };

if (navigator.geolocation) {

  navigator.geolocation.getCurrentPosition(function(position) {
    var pos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    };

    const userIcon = {
      url: document.getElementById('map').dataset.userimage,
      scaledSize: new google.maps.Size(40, 40),
    };

    var marker = new google.maps.Marker({
      position: pos,
      title:"Hello World!",
      visible: true,
      map: map.map,
      icon: userIcon
    });

    console.log('user position:', pos)

  }, function(error) {
    console.error(error)
  });
}
