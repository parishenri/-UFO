import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/material_blue.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

flatpickr("#start_date", {
	altInput: true,
	plugins: [new rangePlugin({ input: "#end_date"})]
});