import 'dart:async';

import 'package:busgo/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:busgo/trackingdirectionsmap/locationservice.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FromTo extends StatefulWidget {
  static const routeName = '/FromTo';
  @override
  State<FromTo> createState() => MapFromToState();
}

class MapFromToState extends State<FromTo> {
  static const routeName = '/FromTo';
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(30.033333, 31.233334));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  late String orginInput;
  late String DestinationInput;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Enter orgin and destination'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: InputDecoration(hintText: ' Origin'),
                      onChanged: (orginInput) {
                        print(orginInput);
                      },
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration: InputDecoration(hintText: ' Destination'),
                      onChanged: (DestinationInput) {
                        print(DestinationInput);
                      },
                    ),
                    ButtonBar(
                      children: [
                        //  TextButton(onPressed: () {}, child: Text("Cancle")),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, '/TrafficSummary');
                          },
                          child: Text("Check traffic"),
                        ),
                      ],
                    ) /*Text(
                        '$Time()',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),*/
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async {
                    var directions = await LocationService().getDirections(
                      // var o=_originController.text;
                      _originController.text,
                      _destinationController.text,
                      // ignore: avoid_print
                      // print(_originController.text);
                    );
                    _goToPlace(
                      directions['start_location']['lat'],
                      directions['start_location']['lng'],
                      directions['bounds_ne'],
                      directions['bounds_sw'],
                    );

                    _setPolyline(directions['polyline_decoded']);
                  },
                  icon: Icon(Icons.search),
                  color: Colors.pink),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),

          ///ME ROLA DYFAH

          /* Visibility(
                         //   visible: _placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $Time km',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*/
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }

/*
Future<LatLng?> getUserLocation() async {

  LocationManager.LocationData? orginInput;

  final location = LocationManager.Location();

  try {

    orginInput = await location.getLocation();

    final lat = orginInput.latitude;

    final lng = orginInput.longitude;

    final center = LatLng(lat!, lng!);

    return center;
    print('the center is $center');

  } on Exception catch (_) {
      print("throwing new error");
      throw Exception("Error on server");

}
}*/

// void Time() async {
//   Dio dio = new Dio();
//   //var dio = Dio();
//   var API_KEY='';
//   final response = await dio.
//   //get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=orginInput&destinations=DestinationInput&key=API_KEY");
//   get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=API_KEY");
//    //printvalue=response.data;
//    late String orginInput;
//  late String DestinationInput;
//   return (response.data);
// }
// void Times(){

// Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// List<Placemark> placemark = await Geolocator().placemarkFromAddress("Gronausestraat 710, Enschede");
//  https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY

// }
}
