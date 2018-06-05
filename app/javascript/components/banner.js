import Typed from 'typed.js';

function loadDynamicBannerText() {
  const banner = document.getElementById('banner-typed-text')
  if (banner) {
    new Typed('#banner-typed-text', {
      strings: ["Being naked is the no.1 most sustainable apparel", "We are no.2"],
      typeSpeed: 45,
      loop: true
    });
  }
}

export { loadDynamicBannerText };
