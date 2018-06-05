import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/light.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
import { loadDynamicBannerText } from '../components/banner';
import { callFlatpickr } from "./flatpickr"


import { autocomplete } from '../components/autocomplete';

autocomplete();
loadDynamicBannerText();
callFlatpickr();