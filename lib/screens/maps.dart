import 'dart:async';
import 'package:fastroute/trackingdirectionsmap/locationservice.dart';
import '../trackingdirectionsmap/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../drawer/drawer.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart'; //Component(Component.country, 'Eg'
//import 'package:google_api_headers/google_api_headers.dart';
//import 'package:google_maps_webservice/places.dart';
//import 'package:permission_asker/permission_asker.dart';
//import 'package:permission_handler/permission_handler.dart';

class FromTo extends StatefulWidget {
  static const routeName = "/FromTo";
  @override
  State<FromTo> createState() => MapFromToState();
}

class MapFromToState extends State<FromTo> {
  static const routeName = "/from-to";
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  late String originInputString = '';
  late String destinationInputString;

  var DistanceofLocation;
  var TimeofLocation;

  late var directions;
  var originPlace;

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  //late String place1;
  //late  String place2;
  String place1 = 'enter origin';
  String place2 = 'enter destination';

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

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
          /*onTap: () {
          print("orginInput");
        //  var XR=Text('$point');
   var t!=orginInput;
         return(<orginInput!>);
 late String OrginInput;
 late String DestinationInput;
         }, */
        ),
      );
    });
  }

  void _setPolygon() {
    //final String polygonIdVal = 'polygon_$_polygonIdCounter';
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Enter orgin and destination'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: 312,
                  child: Column(
                    children: [
                      Positioned(
                        top: 20,
                        child: InkWell(
                          onTap: getPlaceService1,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: double.infinity,
                                child: ListTile(
                                  title: Text(
                                    '$place1',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  dense: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 80,
                        child: InkWell(
                          //desitnation
                          onTap: //(Place place) async {
                              // setState(() {
                              getPlaceService2
                          //});

                          // place1 = place.description!;
                          // print(place);
                          //if (place != null) {
                          //place1 = place.description!;
                          //print(place);
                          //};
                          //  }
                          ,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                //width: width,
                                child: ListTile(
                                  title: Text(
                                    '$place2',

                                    ///destination
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  // trailing: const Icon(Icons.search),
                                  dense: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // SearchMapPlaceWidget(
                      //   hasClearButton: true,
                      //   placeType: PlaceType.address,
                      //   placeholder: 'Enter the location',
                      //   apiKey: Secrets.API_KEY,
                      //   iconColor:Colors.blueGrey,
                      //   //strictBounds :true,

                      //   bgColor :Colors.blueGrey,
                      //   location: LatLng(30.057978,31.212652),
                      //   radius: 181273 ,//608.52 2sto bil km ,544878.02  meter
                      //   onSelected: (Place place) async {
                      //    // place1 = place.description!;
                      //    // print(place);
                      //     if (place != null) {
                      //   place1 = place.description!;
                      //     print(place);
                      //   }

                      //   },
                      // ),

                      // SearchMapPlaceWidget(
                      //   hasClearButton: true,
                      //   bgColor :Colors.blueGrey,
                      //  iconColor:Colors.blueGrey,

                      //   //language: const {'en','ar'},
                      //   placeType: PlaceType.address,
                      //   // controller: _originController,
                      //   placeholder: 'Enter the location',
                      //   apiKey: Secrets.API_KEY,
                      //   location: LatLng(30.057978,31.212652),//30.033333, 31.233334
                      //   radius: 181273,
                      //  // strictBounds: true,
                      //   onSelected: (place) async {
                      //  //   place2 = place.description!;
                      //    // print(place);
                      //     if (place != null) {
                      //   place2 = place.description!;
                      //     print(place);
                      //   }
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  directions =
                      await LocationService().getDirections(place1, place2);

                  DistanceofLocation =
                      await LocationService().getDistance(place1, place2);
                  TimeofLocation =
                      await LocationService().getTime(place1, place2);

                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(
                    directions['polyline_decoded'],
                  );
                  setState(() {
                    TimeofLocation;
                  });
                },
                icon: Icon(Icons.search),
                color: Colors.pink,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      child: TimeofLocation != null
                          ? Text(
                              '${TimeofLocation} ${DistanceofLocation} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            )
                          : Text(''),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/TrafficSummary');
                      },
                      child: Text("Check Traffic"),
                    ),
                  ],
                ),
              ),

              // IconButton(
              //     onPressed: () async {
              //       directions = await LocationService().getDirections(
              //    place1, place2
              //       //  _originController.text,
              //        // _destinationController.text,

              //       );
              //       _goToPlace(
              //         directions['start_location']['lat'],
              //         directions['start_location']['lng'],
              //         directions['bounds_ne'],
              //         directions['bounds_sw'],
              //       );

              //       _setPolyline(directions['polyline_decoded'],

              //       );
              //     },
              //     icon: Icon(Icons.search),
              //     color: Colors.pink,
              //     ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              //title:"hello",
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              // compassEnabled:true,
              //mapToolbarEnabled:true,
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
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
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

  getPlaceService2() async {
    var getplace2 = await PlacesAutocomplete.show(
      context: context,
      apiKey: Secrets.API_KEY,
      startText: "Destinatuion",
      mode: Mode.fullscreen,
      types: [],
      hint: 'Search',
      strictbounds: false,
      components: [Component(Component.country, 'Eg')],
      onError: (err) {
        var snackBar = const SnackBar(content: Text("An Error happened!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
    await displayPrediction2(getplace2, ScaffoldMessenger.of(context));
    print('i am palce to ${place2}');
  }

  getPlaceService1() async {
    var getplace1 = await PlacesAutocomplete.show(
      context: context,
      apiKey: Secrets.API_KEY,
      mode: Mode.fullscreen,
      types: [],
      strictbounds: false,
      components: [Component(Component.country, 'Eg')],
      onError: (err) {
        var snackBar = const SnackBar(content: Text("An Error happened!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
    await displayPrediction1(getplace1, ScaffoldMessenger.of(context));
    print('i am palce to ${getplace1}');
  }

  Future<void> displayPrediction2(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      //print('thhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${p}');
      return;
    }
    // get detail (lat/lng)
    final _places = GoogleMapsPlaces(
      apiKey: Secrets.API_KEY,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lng = geometry.location.lng;
    print('geometry hello2 ${p.description}');
    place2 = p.description!;
    messengerState.showSnackBar(
      SnackBar(
        content: Text('${p.description} - $lat/$lng'),
      ),
    );
  }

  Future<void> displayPrediction1(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      //print('thhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${p}');
      return;
    }
    // get detail (lat/lng)
    final _places = GoogleMapsPlaces(
      apiKey: Secrets.API_KEY,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lng = geometry.location.lng;
    print('geometry hello1 ${p.description}');
    place1 = p.description!;

    messengerState.showSnackBar(
      SnackBar(
        content: Text('${p.description} - $lat/$lng'),
      ),
    );
  }
} /////////endddd


