// ignore_for_file: void_checks, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:busgo/trackingdirectionsmap/locationservice.dart';
import 'package:busgo/trackingdirectionsmap/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
//import 'package:google_maps_webservice/directions.dart';

import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../trackingdirectionsmap/secrets.dart';
import '../drawer/drawer.dart';
//import 'package:google_api_headers/google_api_headers.dart';
//import 'package:google_maps_webservice/places.dart';

//import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
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
  //TextEditingController _originController = TextEditingController();
  // TextEditingController _destinationController = TextEditingController();
  late GoogleMapController mapController;

  late String originInputString = '';
  late String destinationInputString;
//Null emptyNull=null;

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var DistanceofLocation;
  //= LocationService().getDistance("miu", "guc");
  var TimeofLocation;
  //= LocationService().getTime("miu", "guc");

  late var directions;

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  late String place1;
  late String place2;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

  //get yesonnn => null;

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
      drawer:AppDrawer(),
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
                child: 
                Container(
                   width:312,
                  child: Column(
                    children: [
                      SearchMapPlaceWidget(
                        hasClearButton: true,
                        placeType: PlaceType.address,
                        placeholder: 'Enter the location',
                        apiKey: Secrets.API_KEY,
                        iconColor:Colors.blueGrey,
                        //strictBounds :true,

                        bgColor :Colors.blueGrey,
                        location: LatLng(30.057978,31.212652),
                        radius: 181273 ,//608.52 2sto bil km ,544878.02  meter
                        onSelected: (Place place) async {
                         // place1 = place.description!;
                         // print(place);
                          if (place != null) {
                        place1 = place.description!;
                          print(place);
                        }

                        },
                      ),

// Positioned(
//             top: 20,
//             child: InkWell(
//               onTap: getPlaceService,
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Card(
//                   child: Container(
//                     padding: const EdgeInsets.all(0),
//                     width: double.infinity,
//                     child: ListTile(
//                       title: Text(
//                       'location',
//                         style: const TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.search),
//                       dense: true,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

                     

                      SearchMapPlaceWidget(
                        hasClearButton: true,
                        bgColor :Colors.blueGrey,
                       iconColor:Colors.blueGrey,

                        //language: const {'en','ar'},
                        placeType: PlaceType.address,
                        // controller: _originController,
                        placeholder: 'Enter the location',
                        apiKey: Secrets.API_KEY,
                        location: LatLng(30.057978,31.212652),//30.033333, 31.233334
                        radius: 181273,
                       // strictBounds: true,
                        onSelected: (place) async {
                       //   place2 = place.description!;
                         // print(place);
                          if (place != null) {
                        place2 = place.description!;
                          print(place);
                        }

                          // mapController.animateCamera(
                          //   CameraUpdate.newLatLng(geolocation!.coordinates));
                          //mapController.animateCamera(
                          //  CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                        },
                      ),
                      
                    ],
                  ),
                ),
              ),
              IconButton(
                      onPressed: () async {
                        directions =
                            await LocationService().getDirections(place1, place2
                                //  _originController.text,
                                // _destinationController.text,
                                

                                );

                        DistanceofLocation =
                            await LocationService().getDistance(place1, place2);
                        // TimeofLocation=await LocationService().getTime(place1,place2);
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
                          //  DistanceofLocation= LocationService().getDistance(place1,place2) ;

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
                    //                       TextFormField(
                    //                         controller: _originController,
                    //                         decoration: InputDecoration(hintText: ' Origin'),

                    //                         onChanged: (originInput) async {
                    //                          // getSuggestion(orginInput);

                    //                           print(originInput);
                    //                           originInputString=originInput;
                    //                           //print("the ssssssssssssssssssssssssssssss $originInputString");
                    //                           print("the_origidddnController $_originController");

                    //                         },
                    //                       ),
                    //                       TextFormField(
                    //                         controller: _destinationController,
                    //                         decoration: InputDecoration(hintText: ' Destination'),
                    //                         onChanged: (destinationInput) {
                    //                         //  getSuggestion(DestinationInput);
                    //                           print(destinationInput);

                    // destinationInputString=destinationInput;
                    //                           print("the inputtt is $_destinationController.text");
                    //                         },
                    //                        ),
                    // if(TimeofLocation!=null && DistanceofLocation!=null){
                    Container(
                      child: TimeofLocation != null
                          ? Text(
                              '${TimeofLocation} ${DistanceofLocation} ',
                              //The distance is DistanceofLocation & $TimeofLocation
                              //_originController.text, _destinationController.text
                              //"miu","guc"

                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            )
                          : Text(''),
                    ),
                    //   },
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

  //  getPlaceService() async {
    
  //   var place = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: Secrets.API_KEY,
  //       mode: Mode.overlay,
  //       types: [],
  //      strictbounds: false,
       
  //      components: [Component(Component.country, 'Eg')],

        
      
  //     ); 
  //}
}