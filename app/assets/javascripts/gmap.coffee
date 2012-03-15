class window.Gmap
    map: ""
    userPoint: ""
    constructor: (componentName) ->
        $(document).ready ->
            @userPoint = new google.maps.LatLng(-21.293853, -50.338669)
            myOptions = {
                center: @userPoint,
                zoom: 14,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
        
            @map = new google.maps.Map(document.getElementById(componentName), myOptions)
        
            marker = new google.maps.Marker({
                        map: @map,
                        draggable:true,
                        animation: google.maps.Animation.DROP,
                        position: @userPoint
            });