function emailReplace (elems){
    var m = "orgateam" + String.fromCharCode(64) + "nixcon.org";
    elems.attr("href", "mailto:" + m)
    elems.text(m)
}

$( document ).ready(function(){
    $(".button-collapse").sideNav();
    emailReplace($("a.contact-email"));
});



// handle Google Maps stuff
function initialize(mapId, lat, lng) {
    var mapCanvas = document.getElementById(mapId);
    var mapOptions = {
        center: new google.maps.LatLng(lat, lng),
        zoom: 14,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(mapCanvas, mapOptions);

    var styles = [
        {
            stylers: [
                { hue: "#2196f3" },
                { saturation: -50 }
            ]
        },{
            featureType: "road",
            elementType: "geometry",
            stylers: [
                { lightness: 100 },
                { visibility: "simplified" }
            ]
        }
    ];

    var marker = new google.maps.Marker({
        position: {lat: lat, lng: lng},
        map: map
    });
}
