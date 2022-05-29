
// void _listenLocation_Trail2() {
//     location.enableBackgroundMode(enable: true);
//     //final User? user = auth.currentUser;
//     //final uid = user!.uid;
//     GeoData data;
//     var currentlat;
//     var currentlong;
// //get cureent address & lat & long
// //f 10 seconds are passed AND* if the phone is moved at least 5 meters, give the location.
// //location.changeSettings(accuracy: loc.LocationAccuracy.balanced,interval: 1000); ///not sure ,distanceFilter: 2
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print("error in listen location${onError}");

//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((loc.LocationData currentlocation) async {
//       //GeoData
//       data = await Geocoder2.getDataFromCoordinates(
//           latitude: currentlocation.latitude!,
//           longitude: currentlocation.longitude!,
//           googleMapApiKey: Secrets.API_KEY);


//       //Formated Address
//       print("the cureent address is------${data.address}");
//       setState(() {
//          place1 = data.address;
//       });
     
//       currentlong = currentlocation.longitude;
//       currentlat = currentlocation.latitude;

//       print('the current live  lat is ${currentlocation.latitude}');
//       print('the current live long is ${currentlocation.longitude}');

//       setState(() async {  //8t change 
//         // if(currentlocation.isMock==true){
//         if (_locationSubscription != null) {
          
//            setState(() async{
      
//          directions = 
//           await LocationService().getDirections(place1, place2);
//          DistanceofLocation =
//            await LocationService().getDistance(place1, place2);
//          TimeofLocation =
//            await LocationService().getTime(place1, place2);

         
//          setState(() {
//            TimeofLocation;
//             DistanceofLocation;
//            directions;
//          });
            
//             _goToPlace(
//               directions['start_location']['lat'],
//               directions['start_location']['lng'],
//               directions['bounds_ne'],
//               directions['bounds_sw'],
//             );

//             _setPolyline(
//               directions['polyline_decoded'],
//             );
//           });
//          // }), );
//         }
// //}
//       });
//     });
//   }



//   /////////////////////////////////////////////////

// //enable live location
//   void _listenLocation_Trail() {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     GeoData data;

// //get cureent address & lat & long
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print("error in listen location${onError}");
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((loc.LocationData currentlocation) async {
//       //GeoData
//       data = await Geocoder2.getDataFromCoordinates(
//           latitude: currentlocation.latitude!,
//           longitude: currentlocation.longitude!,
//           googleMapApiKey: Secrets.API_KEY);

//       //Formated Address
//       print("the cureent address is------${data.address}");
//       print('the current live  lat is ${currentlocation.latitude}');
//       print('the current live long is ${currentlocation.longitude}');
//     });

// //if(data.address!=)

// //compare
//   }

//  /////////////////////////////////////////
// void UpdateLocation() {
//     setState(() async {
//       final User? user = auth.currentUser;
//       final uid = user!.uid;
//       final loc.LocationData _locationResult = await location.getLocation();
//       GeoData data = await Geocoder2.getDataFromCoordinates(
//           latitude: _locationResult.latitude!,
//           longitude: _locationResult.longitude!,
//           googleMapApiKey: Secrets.API_KEY);

//       var collection = FirebaseFirestore.instance.collection('Location');
//       var name;
//       try {
//         collection
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots()
//             .listen((docSnapshot) {
//           if (docSnapshot.exists) {
//             Map<String, dynamic> data = docSnapshot.data()!;

//             // You can then retrieve the value from the Map like this:
//             name = data['origin'];
//             print("the saved value in datastore is ${name}");
//           }
//         });
//       } catch (e) {
//         print("errrrrrrrrrrrrorrr${e}");
//       }

//       try {
//         //Formated Address
//         print("the cureent address is------${data.address}");

//         await FirebaseFirestore.instance
//             .collection('Location')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .set({
//           'latitude': _locationResult.latitude,
//           'longitude': _locationResult.longitude,
//           //'Latitude':latit,
//           //'Longitude': long,
//           'User_Id': uid,
//           //'user': user,
//           //'origin':placemarkFromCoordinates(_locationResult.latitude!,_locationResult.longitude!),
//           'origin': data.address,
//           'destination': place2,
//         }, SetOptions(merge: true));
//       } catch (e) {
//         print("errrrrrrrrrrrrorrr${e}");
//         //print("errrrrrrrrrrrrorrr${user}");
//         // print("errrrrrrrrrrrrorrr${uid}");
//         // print("errrrrrrrrrrrrorrr${latit}");
//         // print("errrrrrrrrrrrrorrr${long}");
//         // print("errrrrrrrrrrrrorrr${place1}");
//         // print("errrrrrrrrrrrrorrr${place2}");
//       }
//       if (data.address != name) {
//         FirebaseFirestore.instance
//             .collection('Location')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .set(
//           {
//             'latitude': _locationResult.latitude,
//             'longitude': _locationResult.longitude,
//             //'Latitude':latit,
//             //'Longitude': long,
//             'User_Id': uid,
//             //'user': user,
//             //'origin':placemarkFromCoordinates(_locationResult.latitude!,_locationResult.longitude!),
//             'origin': name,
//             'destination': place2,
//           },
//         );
//         print("the updated value is ${name}");

//         directions = await LocationService().getDirections(name, place2);
//         DistanceofLocation = await LocationService().getDistance(name, place2);
//         TimeofLocation = await LocationService().getTime(name, place2);
//         _goToPlace(
//           directions['start_location']['lat'],
//           directions['start_location']['lng'],
//           directions['bounds_ne'],
//           directions['bounds_sw'],
//         );

//         _setPolyline(
//           directions['polyline_decoded'],
//         );
//         setState(() {
//           TimeofLocation;
//           DistanceofLocation;
//           directions;
//         });
//       }
//     });
//   } 



// /////////////////////////////////////////////
// //put input to the firebase add my current location
//   _getLocation() async {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     try {
//       final loc.LocationData _locationResult = await location.getLocation();
//       GeoData data = await Geocoder2.getDataFromCoordinates(
//           latitude: _locationResult.latitude!,
//           longitude: _locationResult.longitude!,
//           googleMapApiKey: Secrets.API_KEY);

//       //Formated Address
//       print("the cureent address is------${data.address}");

//       await FirebaseFirestore.instance
//           .collection('Location')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set({
//         'latitude': _locationResult.latitude,
//         'longitude': _locationResult.longitude,
//         //'Latitude':latit,
//         //'Longitude': long,
//         'User_Id': uid,
//         //'user': user,
//         //'origin':placemarkFromCoordinates(_locationResult.latitude!,_locationResult.longitude!),
//         'origin': data.address,
//         'destination': place2,
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print("errrrrrrrrrrrrorrr${e}");
//       //print("errrrrrrrrrrrrorrr${user}");
//       // print("errrrrrrrrrrrrorrr${uid}");
//       // print("errrrrrrrrrrrrorrr${latit}");
//       // print("errrrrrrrrrrrrorrr${long}");
//       // print("errrrrrrrrrrrrorrr${place1}");
//       // print("errrrrrrrrrrrrorrr${place2}");
//     }
//   }
//   /////////////////////////////////////////////////////////////////