import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/material_blue.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";


const dates = JSON.parse(document.getElementById('bookedDates').dataset.dates);

const calendar = flatpickr("#start_date", {
	altInput: true,
	disable: [dates]
	plugins: [new rangePlugin({ input: "#end_date"})]
});
