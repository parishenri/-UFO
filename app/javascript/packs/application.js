import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/material_blue.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
import { loadDynamicBannerText } from '../components/banner';
loadDynamicBannerText();


// const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

// flatpickr("#start_date", {
// 	altInput: true,
// 	disable: dates,
// 	plugins: [new rangePlugin({ input: "#end_date"})]
// });


const div = document.getElementById('bookedDates')
if (div) {
  const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

  flatpickr("#start_date", {
    altInput: true,
    enable: dates,
    plugins: [new rangePlugin({ input: "#end_date"})]
  });
}

flatpickr("#available_start_date", {
 altInput: true,
 plugins: [new rangePlugin({ input: "#available_end_date"})]
});

