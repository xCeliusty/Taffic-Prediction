import 'package:busgo/drawer/drawer.dart';
import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _EditprofileState createState() => _EditprofileState();
}

const routeName = "/Editprofile";

class _EditprofileState extends State<Editprofile> {
  static const routeName = "/dashboard";
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
        body: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const ListTile(
                    tileColor: Colors.blueGrey,
                    title: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lora-VariableFont_wght',
                        fontSize: 25,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  elevation: 30,
                  color: Color(0xff36344b),
                  margin:
                      EdgeInsets.only(bottom: 40, top: 60, left: 90, right: 90),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Name:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Lora-VariableFont_wght',
                                  color: Colors.black)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: TextFormField(
                                      cursorColor: Color(0XFFFFCCFF),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: null,
                                        hintText: 'Edit your name',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6c6996),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Text('Email:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Lora-VariableFont_wght',
                                  color: Colors.black)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: TextFormField(
                                      cursorColor: Color(0XFFFFCCFF),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: null,
                                        hintText: 'Edit your Email',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6c6996),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Text('ID:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Lora-VariableFont_wght',
                                  color: Colors.black)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: TextFormField(
                                      cursorColor: Color(0XFFFFCCFF),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: null,
                                        hintText: 'Edit your ID',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6c6996),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Text('Password:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Lora-VariableFont_wght',
                                  color: Colors.black)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: TextFormField(
                                      cursorColor: Color(0XFFFFCCFF),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: null,
                                        hintText: 'Edit your password',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6c6996),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: Text(
                        'Discard',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 30,
                          fontFamily: 'Lora-VariableFont_wght',
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/third');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 30,
                            fontFamily: 'Lora-VariableFont_wght',
                          ),
                        ))
                  ],
                )
              ],
            )));
  }
}
