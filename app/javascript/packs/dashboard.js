var items = document.querySelectorAll('.js-click');
items.forEach(function(calendar) {
  console.log(calendar);
  calendar.addEventListener("click", function(){
    document.querySelector(".active").classList.remove("active");
    document.querySelector("#show-calendar-tab").classList.add("active");
  });
});

