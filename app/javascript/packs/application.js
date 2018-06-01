import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/material_blue.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";


// const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

// flatpickr("#start_date", {
// 	altInput: true,
// 	disable: dates,
// 	plugins: [new rangePlugin({ input: "#end_date"})]
// });



const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

flatpickr("#start_date", {
 altInput: true,
 enable: dates,
 plugins: [new rangePlugin({ input: "#end_date"})]
});


const datesForSearch = JSON.parse(document.getElementById('allDates').dataset.dates);
flatpickr("#start_date", {
 altInput: true,
 disable: datesForSearch,
 plugins: [new rangePlugin({ input: "#end_date"})]
});
