import "bootstrap";
import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/light.css";
import { loadDynamicBannerText } from '../components/banner';


import { autocomplete } from '../components/autocomplete';

autocomplete();
loadDynamicBannerText();
