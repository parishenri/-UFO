import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/light.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";


const start_date = document.getElementById('start_date');

if (start_date) {
  const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

  flatpickr("#start_date", {
    altInput: true,
    enable: dates,
    plugins: [new rangePlugin({ input: "#end_date"})]
  });
}


const available_start_date = document.getElementById('available_start_date')

if (available_start_date) {
  flatpickr("#available_start_date", {
   altInput: true,
   plugins: [new rangePlugin({ input: "#available_end_date"})]
  });
}

const start_date_search = document.getElementById('start_date_search')

if (start_date_search) {
  flatpickr("#start_date_search", {
   altInput: true,
   plugins: [new rangePlugin({ input: "#end_date_search"})]
  });
}

const datesdiv = document.getElementById('allDates')
if (datesdiv) {
  const datesForSearch = JSON.parse(datesdiv.dataset.dates);
  flatpickr("#start_date", {
   altInput: true,
   disable: datesForSearch,
   plugins: [new rangePlugin({ input: "#end_date"})]
  });
}
export { callFlatpickr }