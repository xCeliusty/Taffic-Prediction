import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;
import 'package:fastroute/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
//import 'package:googleapis/vision/v1.dart';

class Editprofile extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _EditprofileState createState() => _EditprofileState();
}

const routeName = "/Editprofile";
var UID;
getData() {
  if (FirebaseAuth.instance.currentUser != null) {
    UID = FirebaseAuth.instance.currentUser!.uid;
  }
  return UID;
}

class _EditprofileState extends State<Editprofile> {
  //final FirebaseAuth auth = FirebaseAuth.instance;
//User? get user => auth.currentUser;
//get uid => user!.uid;

  // void currentInfoUser() {
  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots();
  //   var collection = FirebaseFirestore.instance.collection('users');
  //   var name;
  //   try {
  //     collection
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .snapshots()
  //         .listen((docSnapshot) {
  //       if (docSnapshot.exists) {
  //         Map<String, dynamic> data = docSnapshot.data()!;

  //         // You can then retrieve the value from the Map like this:
  //         var user_email = data['email']; //phoneNumber //username
  //         var user_phoneNumber = data['phoneNumber'];
  //         var user_name = data['username'];

  //         print("the saved value in datastore is ${name}");
  //         //return [user_email,user_phoneNumber];
  //       }
  //     });
  //   } catch (e) {
  //     print("errrrrrrrrrrrrorrr${e}");
  //   }
  // }

  bool flag = false;
  static const routeName = "/dashboard";
  // final picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();

  File? pickedImage;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  //new////////////////
  File? _imageFile = null;
  String _imageUrl = "";

  // Only supported on Android & iOS
  final picker = ImagePicker();

  User? user;
  Stream<QuerySnapshot>? userInfo;
  void getUserData() {
    userInfo = FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: Userid)
        .snapshots();
  }
  //FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots()

  //UserModel? userModel;
  // DatabaseReference taskRef = FirebaseDatabase.instance.reference().child('tasks').child(uid);
  // DatabaseReference? userRef;
  bool showLocalFile = false;
  // DataBaseReference? userRef;

  var Userid = getData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  TextEditingController addressTextController = new TextEditingController();
  TextEditingController phoneNumberTextController = new TextEditingController();
  TextEditingController nameTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueGrey,
      ),

      // backgroundColor: Color(0xff36344b),

      body: StreamBuilder<QuerySnapshot>(
        ///Stream<DocumentSnapshot> provideDocumentFieldStream()
        stream: userInfo,
        // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            // (
            //   BuildContext context,
            //   AsyncSnapshot<QuerySnapshot> snapshot,  ///(context, AsyncSnapshot<User> snapshot)
            // )
            {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                if (data.docs[index]["image"] != null &&
                    data.docs[index]["image"] != "") {
                  _imageUrl =
                      "https://firebasestorage.googleapis.com/v0/b/traffic-prediction-f4eb7.appspot.com/o/${data.docs[index]["image"]}?alt=media&token=abd22c86-20f9-4e68-b11e-7d1b338b7bb4";
                }
                //x = data.docs['FirebaseAuth.instance.currentUser!.uid']["username"];
                return Container(
                  //decoration: BoxDecoration(color: Colors.green),
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),

                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                     Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                       // mainAxisAlignment: MainAxisAlignment.start,
                        //           innerDistance: 8.0,
                        // outerDistance: -100.0,
                       children: [
                          imagwidget(),
                          cameraIconWidget(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 10),
                      //     child: ClipRRect(
                      //       borderRadius: new BorderRadius.circular(8.0),
                      //       child: Image.asset(
                      //         'assets/person2.jpg',
                      //         height: 80,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //1
                      //Column(
                      //  children: [
                      TextField(
                        readOnly: false,
                        controller: nameTextController,
                        textAlign: TextAlign.left,
                        
                        // decoration: InputDecoration(
                          
                        //   prefixIcon: Icon(
                        //     Icons.person,
                        //     color: Colors.blueGrey,
                        //   ),
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   borderSide: const BorderSide(color: Colors.pink, width: 20),
                        //   ),

                          
                        //   // fillColor: Colors.white, //background of phonenumber
                        //   //filled: true, // To set background to light grey
                        //   hintText: "${data.docs[index]["username"]}",
                        // ),

                        decoration: new InputDecoration(
                            prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blueGrey,
                          ),
    enabledBorder:  OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
       borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),
    ),
    border: const OutlineInputBorder(),
    labelStyle: new TextStyle(color: Colors.blueGrey,),
   hintText: "${data.docs[index]["username"]}",
  ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 0.01,

                          //width:
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // ],
                      // ),
                      //2
                      //Column(
                      // children: [
                      TextField(
                        readOnly: true,
                        textAlign: TextAlign.left,
                       decoration: new InputDecoration(
                            prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
    enabledBorder:  OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
       borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),
    ),
    border: const OutlineInputBorder(),
    labelStyle: new TextStyle(color: Colors.blueGrey,),
   hintText: "${data.docs[index]["email"]}",
  ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            height: 0.01,
                            color: Colors.black),
                      ),
                      
                      SizedBox(
                        height: 15,
                      ),
                      // ],
                      // ),

                      // //3
                      //  Column(
                      //  children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 200),
                      //   child: Text(
                      //     'Phone Number',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      TextField(
                        //readOnly: true,
                        autocorrect: true,
                        controller: phoneNumberTextController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(
                            Icons.phone_android_outlined,
                            color: Colors.blueGrey,
                          ),
    enabledBorder:  OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
       borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),
    ),
    border: const OutlineInputBorder(),
    labelStyle: new TextStyle(color: Colors.blueGrey,),
   hintText: "${data.docs[index]["phoneNumber"]}",
  ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            height: 0.01,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //  ],
                      //),
                      //4
                      // Column(
                      //   children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 200),
                      //   child: Text(
                      //     'Phone Number',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        
                        child: TextField(
                          //readOnly: true,
                          controller: addressTextController,
                          textAlign: TextAlign.start,

                          decoration: new InputDecoration(
                              prefixIcon: Icon(
                              Icons.place_outlined,
                              color: Colors.blueGrey,
                            ),
    enabledBorder:  OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
       borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.blueGrey, width: 5.0),
      
    ),
    border: const OutlineInputBorder(),
    labelStyle: new TextStyle(color: Colors.blueGrey,),
   hintText: "${data.docs[index]["address"]}",
  ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 0.01,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //  ],
                      //  ),

                      //5
                      // Column(
                      //  children: [
                      ButtonBar(
                        children: [
                          //  TextButton(onPressed: () {}, child: Text("Cancle")),
                          ElevatedButton(
                            onPressed: () {
                              if (addressTextController.text == null ||
                                  addressTextController.text == '') {
                                addressTextController.text =
                                    data.docs[index]["address"];
                              }
                              if (nameTextController.text == null ||
                                  nameTextController.text == '') {
                                nameTextController.text =
                                    data.docs[index]["username"];
                              }
                              if (phoneNumberTextController.text == null ||
                                  phoneNumberTextController.text == '') {
                                phoneNumberTextController.text =
                                    data.docs[index]["phoneNumber"];
                              }

                              InsertTextInFirestore(
                                  addressTextController.text,
                                  phoneNumberTextController.text,
                                  nameTextController.text);
                              // Navigator.pushNamed(context, '/DriverDetails1');
                              Navigator.pushNamed(context, '/FromTo');
                            },
                            child: Text("Confirm"),
                          ),
                        ],
                      ),
                      //   ],
                      // )
                    ],
                  ),
                );
              },
            );
          }
          // if (snapshot.connectionState == ConnectionState.waiting) { //snapshot.hasData && snapshot.connectionState == ConnectionState.active
          //   return Text("Loading");
          // }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  showPopUpMenu() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('With Camera'),
                onTap: () {
                  pickImageCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.storage),
                title: Text('From Gallery'),
                onTap: () {
                  pickImageFromDevice();
                },
              ),
            ],
          );
        });
  }

  File? imageFile;

  pickImageFromDevice() async {
    //final ImagePicker _picker2 = ImagePicker();
    //final
    //XFile? file= await _picker.pickImage(source: ImageSource.gallery);
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    //  if(pickedFile==null) return;
    // pickedImage=File(pickedFile.path);
    imageFile = pickedImage;
    print('the file path is ${pickedFile}');

    // showLocalFile = true;
    // setState(() {
    //    imageFile = pickedImage;

    // });

    setState(() {
      _imageFile = File(pickedFile!.path);
      // InsertImagePathFirestore(pickedFile.path);
    });

    uploadImageToFirebaseStorage(context); //save image it self in firstore
  }

  Future pickImageCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path); //dah eli byprint el path fil camera
    });
    uploadImageToFirebaseStorage(context); //save image it self in firstore
  }

  Future uploadImageToFirebaseStorage(BuildContext context) async {
    String fileName = p.basename(_imageFile!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/$fileName'); //.child('uploads')

    final metadata = firebase_storage.SettableMetadata(
        //contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);

    uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);
    print("the current image is ${uploadTask}");
    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {
              print("Upload file path ${value.ref.fullPath}"),
              InsertImagePathFirestore(value.ref.fullPath), //path of image only
            })
        .onError((error, stackTrace) => {
              print("Upload file path error ${error.toString()} "),
            });

    // putImageInFirebaseStorage( fileName, metadata);
  }

// Future putImageInFirebaseStorage(String fileName,final metadata) async {

// firebase_storage.Reference ref =
//     firebase_storage.FirebaseStorage.instance
//         .ref().child('uploads').child('/$fileName');
//         firebase_storage.UploadTask uploadTask;
//     //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
//     uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);

// firebase_storage.UploadTask task= await Future.value(uploadTask);
//     Future.value(uploadTask).then((value) => {
//     print("Upload file path ${value.ref.fullPath}")
//     }).onError((error, stackTrace) => {
//       print("Upload file path error ${error.toString()} ")
//     });

//   }

  void InsertImagePathFirestore(var imagepath) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'User_Id': uid,
          //'user': user,
          //'origin':placemarkFromCoordinates(_locationResult.latitude!,_locationResult.longitude!),address

          'image': imagepath!,
        },
      );
    } catch (e) {
      print("errrrrrrrrrrrrorrr${e}");
      //print("errrrrrrrrrrrrorrr${user}");
      // print("errrrrrrrrrrrrorrr${uid}");
      // print("errrrrrrrrrrrrorrr${latit}");
      // print("errrrrrrrrrrrrorrr${long}");
      // print("errrrrrrrrrrrrorrr${place1}");
      // print("errrrrrrrrrrrrorrr${place2}");
    }
    ;
  }

  void InsertTextInFirestore(
      String address, String phoneNumber, String username) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'User_Id': uid,
          'address': address,
          'phoneNumber': phoneNumber,
          'username': username,
        },
      );
    } catch (e) {
      print("errrrrrrrrrrrrorrr${e}");
      //print("errrrrrrrrrrrrorrr${user}");
      // print("errrrrrrrrrrrrorrr${uid}");
      // print("errrrrrrrrrrrrorrr${latit}");
      // print("errrrrrrrrrrrrorrr${long}");
      // print("errrrrrrrrrrrrorrr${place1}");
      // print("errrrrrrrrrrrrorrr${place2}");
    }
    ;
  }

  Widget imagwidget() => Container(
    margin: EdgeInsets.only(left:10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey,
          border: Border.all(
            width: 5,
            color: Colors.blueGrey,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 300.0,
          minWidth: 100.0,
          maxHeight: 200,
          minHeight: 50,
        ),
        child: ClipRRect(
          // radius: 50,
          borderRadius: BorderRadius.circular(100.0),

          child: _imageUrl != ""
              ? Image.network(_imageUrl)
              : Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 70,
                ),

          //  backgroundImage: NetworkImage(userModel!prifileImagr),
        ),
      );

  Widget cameraIconWidget() => //    new Positioned(
      // top: -10000,
      // bottom: 10,
      // left: 25,

      //   child:
      Container(
        margin:
        //EdgeInsets.only(right:50, top: 120),
        EdgeInsets.only(right:50, top:120),
        // padding:EdgeInsets.only(top: 100.0, left: 50.0, right: 30.0, bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          border: Border.all(
            width: 5,
            color: Colors.blueGrey,
          ),
        ),
        child: IconButton(
            onPressed: () async {
              //final XFile? image = await _picker.pickImage(source: .gallery);
              showPopUpMenu();
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 35,
            )),
      );

  //);
} ////////////////////
