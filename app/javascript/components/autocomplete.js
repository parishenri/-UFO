function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    // var userAddress = document.getElementById('user_address');
    var userAddresses = document.querySelectorAll('#user_address');

    userAddresses.forEach((userAddress) => {
      if (userAddress) {
      var autocomplete = new google.maps.places.Autocomplete(userAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(userAddress, 'keydown', function(e) {
        document.querySelector(".pac-container").style.display = "block";
        document.querySelector(".pac-container").style.zIndex = 9999999;
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });

    }
    })
  });
}
export { autocomplete };

