import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

var mapElement = document.getElementById('map');
let map

if (mapElement) {
  map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers = JSON.parse(mapElement.dataset.markers);
  if (markers != null) {
    map.addMarkers(markers);
    if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(13);
    } else {
      map.fitLatLngBounds(markers);
    }
  } else {
    map.setZoom(2);
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      map.setCenter(pos.lat, pos.lng);
      map.setZoom(13);
    });
  }


if (navigator.geolocation) {

  navigator.geolocation.getCurrentPosition(function(position) {
    var pos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    };

    const userIcon = {
      url: document.getElementById('map').dataset.userimage,
      scaledSize: new google.maps.Size(55, 55),
    };

    var marker = new google.maps.Marker({
      position: pos,
      title:"Hello World!",
      visible: true,
      map: map.map,
      icon: userIcon
    });

  }, function(error) {
    console.error(error)
  });
}
}
autocomplete();