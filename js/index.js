function emailReplace(elems) {
  var m = "orgateam" + String.fromCharCode(64) + "nixcon.org";
  elems.getAttribute("href", "mailto:" + m)
  elems.textContent = m
}

function ready(fn) {
  if (document.readyState != 'loading') {
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function toggleNav() {
  var x = document.getElementById("nav");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}

function initSite() {
  document.querySelectorAll("a.contact-email").forEach(e => emailReplace(e));
}

ready(initSite);