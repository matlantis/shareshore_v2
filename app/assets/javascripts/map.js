drawmap = function(center_coord, marker_coords, bound_n, bound_s, bound_e, bound_w)
{
    var map = new OpenLayers.Map("mapid");

    var wms = new OpenLayers.Layer.WMS(

     "OpenLayers WMS",

     "http://labs.metacarta.com/wms/vmap0",
     
     {layers: 'basic'}
     
   );

   var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
   var toProjection   = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
   var zoom;
   var position;
   var center_position;

   map.addLayer(new OpenLayers.Layer.OSM());
   
   var bounds = new OpenLayers.Bounds();

   bounds.extend(new OpenLayers.LonLat( bound_n[0], bound_n[1]).transform( fromProjection, toProjection));
   bounds.extend(new OpenLayers.LonLat( bound_s[0], bound_s[1]).transform( fromProjection, toProjection));
   bounds.extend(new OpenLayers.LonLat( bound_e[0], bound_e[1]).transform( fromProjection, toProjection));
   bounds.extend(new OpenLayers.LonLat( bound_w[0], bound_w[1]).transform( fromProjection, toProjection));

   center_position = new OpenLayers.LonLat( center_coord[0], center_coord[1]).transform( fromProjection, toProjection);
   /* bounds.extend(center_position);*/


   var markers = new OpenLayers.Layer.Markers( "Markers" );
   map.addLayer(markers);
   markers.addMarker(new OpenLayers.Marker(center_position));
   var iconsize = new OpenLayers.Size(21,25);
   var icon = new OpenLayers.Icon('http://www.openlayers.org/api/img/marker-blue.png', iconsize);

    for (i=0; i<marker_coords.length; i++)
    {
        position = new OpenLayers.LonLat( marker_coords[i][0], marker_coords[i][1]).transform( fromProjection, toProjection);
        markers.addMarker(new OpenLayers.Marker(position, icon.clone()));
    }

   zoom = map.getZoomForExtent(bounds);
   console.log("zoom: " + zoom);
   map.setCenter(center_position, zoom );

}

drawmap2 =function() {
    new ol.Map({
    layers: [
      new ol.layer.Tile({source: new ol.source.OSM()})
    ],
    view: new ol.View({
      center: [0, 0],
      zoom: 2
    }),
    target: 'mapid'
  });
}
