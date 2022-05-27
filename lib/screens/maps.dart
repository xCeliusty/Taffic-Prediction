import 'dart:async';
import 'package:fastroute/trackingdirectionsmap/locationservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:provider/provider.dart';
import '../trackingdirectionsmap/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../drawer/drawer.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart'; //Component(Component.country, 'Eg'
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
//import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;


//import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoder2/geocoder2.dart';

class FromTo extends StatefulWidget {
  static const routeName = "/FromTo";
  @override
  State<FromTo> createState() => MapFromToState();
}

class MapFromToState extends State<FromTo> {
  static const routeName = "/from-to";
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final loc.Location location = loc.Location(); 
  StreamSubscription<loc.LocationData>? _locationSubscription;
  late var latit;
  late var long;

  late String originInputString = '';
  late String destinationInputString;

  //bool _added = false;
  late String user_id;

  var DistanceofLocation;
  var TimeofLocation;
 /* late*/ var directions; 

  var originPlace;

  // Set<Marker> _markers = Set<Marker>();
Set<Marker> _markers = Set<Marker>();
  //Map<Marker> markers = Map<Marker>{}; //defto
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  //int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  //late String place1;
  //late  String place2;
  String place1 = 'Enter Origin';
  String place2 = 'Enter Destination';

  void initState() {
    super.initState();
    _requestPermission();
    // _requestPermission;
    place1;
    place2;

    _setMarker(LatLng(30.033333, 31.233334));
    location.changeSettings(interval: 1000, accuracy: loc.LocationAccuracy.low,distanceFilter: 10);
    location.enableBackgroundMode(enable: true);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: //latlng(snapshot.data!.docs.singlewhere((element)=> element.id==widget.user_id)['latitude']['longitude']);

        LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          
          markerId: MarkerId('marker'),
          position: point,
          infoWindow: InfoWindow(
            title: "A",onTap: (){
              
                TextField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                       decoration: new InputDecoration(
                            prefixIcon: Icon(
                            Icons.place,
                            color: Colors.blueGrey,
                          ),
    enabledBorder:  OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),
    ),
    border: const OutlineInputBorder(),
    labelStyle: new TextStyle(color: Colors.black,),
   hintText: "A",
  ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            height: 0.01,
                            color: Colors.black),
                      );

                },snippet: ""
          ),
          //icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),///-------
          //icon:false,
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
    //_polygonIdCounter++;
  }

  void _setPolyline(List<PointLatLng> points) {
   
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
   
    
      //3shan t3mli update li tlween el shwr3
      _polylineIdCounter++;
      TimeOfDay selectedTime = TimeOfDay.now();
        setState(() {
           
     
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
 });

   // });
  }

void _reomvePolyline (List<PointLatLng> points){
  final String polylineIdVal = 'polyline_$_polylineIdCounter';
   _polylineIdCounter++;
_polylines.removeWhere((m) => m.polylineId.value == 'polyline_$_polylineIdCounter');

}


 void _clearPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;
  
     setState(() {
       
    
    _polylines.clear(
        );
         _polylines.remove(Polyline(polylineId: PolylineId(polylineIdVal),points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),));
     },);
  }
  
  TimeOfDay selectedTime = TimeOfDay.now();
 int clear_polyline=0;
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
      body:
          // StreamBuilder(
          // stream: FirebaseFirestore.instance.collection("Location").snapshots(),
          // builder: ( context, AsyncSnapshot <QuerySnapshot> snapshot) {
          // return
          Column(
        children: [
          Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: 350,
                  child: Column(
                    children: [
                      Positioned(
                        //top: 20,
                        child: InkWell(
                          onTap: getPlaceService1,
                         // child: Padding(
                          //  padding: const EdgeInsets.all(15),
                            child:
                             Card(
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
                         // ),
                        ),
                      ),
                      Positioned(
                       // top: 80,
                        child: InkWell(
                          //desitnation
                          onTap: getPlaceService2,
                        //  child: Padding(
                          //  padding: const EdgeInsets.all(15),
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
                        //  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  _requestPermission();
                  //UpdateLocation();
                  // _listenLocation_Trail();
                  //UpdateLocation();
                 // _listenLocation_Trail2();
                  //_getLocation(); ///////////////////////
                  // _getUserLocation();
                  // _listenLocation();
                        


//directions['polyline_decoded'].remove();

                  // if(directions['polyline_decoded']!=null || directions['polyline_decoded'].isNotempty()){
                  //   _reomvePolyline(directions['polyline_decoded']);
                  if(clear_polyline!=0){
                    _clearPolyline(directions['polyline_decoded']);
                    }
                    clear_polyline=1;
                      //    _markers.clear();
                        ///  directions['polyline_decoded'].clear();
                      //  directions['start_location']['lat'].clear();
                      //     directions['start_location']['lng'].clear();
                      //     directions['bounds_ne'].clear();
                      //     directions['bounds_sw'].clear();
                      //     directions['polyline_decoded'].clear();

                      // }
                       //}),
                     //directions = null;
                       print("Here $directions");

                        directions = await LocationService().getDirections(place1, place2);
                        DistanceofLocation = await LocationService().getDistance(place1, place2);
                        TimeofLocation =await LocationService().getTime(place1, place2);
                        
                          TimeofLocation;
                          DistanceofLocation;
                          directions;
                           setState(() {

                          _goToPlace(
                          directions['start_location']['lat'],
                          directions['start_location']['lng'],
                          directions['bounds_ne'],
                          directions['bounds_sw'],
                        );

                        
                        //   _goToPlace(
                        //   directions['end_location']['lat'],
                        //   directions['end_location']['lng'],
                        //   directions['bounds_ne'],
                        //   directions['bounds_sw'],
                        // );
                        //directions = null;
                        print(1);
                      print(directions["polyline_decoded"]);
                        _setPolyline(
                          directions['polyline_decoded']
                        );
                        
                        });

              /*    if(directions['polyline_decoded']!=null || directions['polyline_decoded'].isNotempty()){
                          _clearPolyline(directions['polyline_decoded']);
                          _markers.clear();
                       }
                  
                  directions =await LocationService().getDirections(place1, place2);
                  DistanceofLocation =await LocationService().getDistance(place1, place2);
                 TimeofLocation =await LocationService().getTime(place1, place2);


 // setState(() {

                   LocationService().getDirections(place1, place2); 
                    LocationService().getDistance(place1, place2);
                    LocationService().getTime(place1, place2);

                
                   
                 directions;
                    DistanceofLocation;
                    TimeofLocation;
 
                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(
                    directions['polyline_decoded'],
                  );*/
                
            // });
                },
                icon: Icon(Icons.search),
                color: Colors.blueGrey,
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
            ],
          ),
          Row(children: [
        ElevatedButton(
          
                onPressed: () {
                 // var timeText='';
                  _selectTime(context);
                },
              child:  Text("time-selected: ${selectedTime.hour}:${selectedTime.minute}"),
            ),
           // Text("${selectedTime.hour}:${selectedTime.minute}"),
        
      //       showTimePicker(
      //   context: context,
      //   initialTime: selectedTime,
      //   initialEntryMode: TimePickerEntryMode.input,
      //   confirmText: "CONFIRM",
      //   cancelText: "NOT NOW",
      //     helpText: "BOOKING TIME",
      // ),
          ],),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers:
                 
                  Set.of(_markers),
                //  Set<Marker>.of(markers.values), //defto
             // myLocationButtonEnabled:true,
             // myLocationEnabled:true,
            //  trafficEnabled: true,
           
              //defto
              //title:"hello",
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              // myLocationButtonEnabled: true,
              
              // compassEnabled:true,
              //mapToolbarEnabled:true,

              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller.complete(controller);
                  

                 // _added = true;
                });
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
      // },

      //),
    );
  }

/**********************functions********************************************************/

//location on camera wa set marker
  Future<void> _goToPlace(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 30), //zoom: 12
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          30),
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
    print('i am palce1 to ${getplace1}');
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
    //final lat = geometry.location.lat;
    //final lng = geometry.location.lng;
    latit = geometry.location.lat;
    long = geometry.location.lng;
    print('laaaaaaaaaaaaaaaat ${latit}');
    print('laaaaaaaaaaaaaaaat ${long}');

    print('geometry hello1 ${p.description}');
    place1 = p.description!;

    messengerState.showSnackBar(
      SnackBar(
        content: Text(
            '${p.description} - $geometry.location.lat/$geometry.location.lng'),
      ),
    );
  }

//request from user tracklive location
  _requestPermission() async {
    var status = await Permission.location.request();
    //var status = await Permission.location.status;
    //var status = Permission.location;
    if (status.isGranted) {
      print('permission is granted!');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      print('isPermanentlyDenied');
    }
  }

// //Stop live location
//   _StopListeningLocation() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }

//MaterialButton(




  _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,

      );
      if(timeOfDay != null && timeOfDay != selectedTime)
        {
          setState(() {
            selectedTime = timeOfDay;
          });
        }
  }

} /////////endddd
