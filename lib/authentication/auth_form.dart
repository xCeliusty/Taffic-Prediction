 import 'package:busgo/screens/maps.dart';
import 'package:busgo/screens/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:busgo/admin/admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _login = true;

  String _username = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  String _address = "";

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data submitted successfully")));
      Navigator.of(context).pushNamed(FromTo.routeName);
      // Navigator.pushNamed(context, '/FromTo');
      // if (_email == "admin@admin.com" && _password == "admin123") {
      //   Navigator.of(context).pushNamed(FromTo.routeName);
      //   Navigator.pushNamed(context, '/FromTo');
      // }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter all fields")));
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Theme.of(context).accentColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.directions_bus,
                    size: 50,
                  ),
                  if (!_login)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ), // icon is 48px widget.
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        onChanged: (value) {
                          _username = value;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.email,
                            color: Colors.black,
                          ), // icon is 48px widget.
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter your email address';
                        }
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const ValueKey('password'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ), // icon is 48px widget.
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Please enter at least 8 characters';
                        }
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  ),
                  if (!_login)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('phoneNumber'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ), // icon is 48px widget.
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                      ),
                    ),
                  if (!_login)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('address'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ), // icon is 48px widget.
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                        onChanged: (value) {
                          _address = value;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (!_login) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _password);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }

                            DocumentReference ref = FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid);
                            FirebaseFirestore.instance.runTransaction(
                              (transaction) async {
                                DocumentSnapshot snapshot =
                                    await transaction.get(ref);
                                if (!snapshot.exists) {
                                  ref.set(
                                    {
                                      'username': _username,
                                      'email': _email,
                                      'phoneNumber': _phoneNumber,
                                      'address': _address,
                                    },
                                  );
                                }
                              },
                            );

                            _login = true;
                          }

                          if (_login) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password);
                              //Navigator.of(context).pushNamed(FromTo.routeName);
                              Navigator.pushNamed(context, '/FromTo');
                              if (_email == "admin@admin.com" &&
                                  _password == "123456")
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AdminScreen(),
                                ));
                              else
                                Navigator.of(context)
                                    .pushNamed(FromTo.routeName);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                const snackBar = SnackBar(
                                      duration: Duration(seconds: 5),
                                      content: Text(
                                          "No user found for that email."));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                              } else if (e.code == 'wrong-password') {
                                const snackBar = SnackBar(
                                      duration: Duration(seconds: 5),
                                      content: Text(
                                          "No user found for that email."));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                print('Wrong password provided for that user.');
                              }
                            }
                          }
                        },
                        child: Text(
                          _login ? "Sign in" : "Sign up",
                          style: const TextStyle(fontSize: 20),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            _login = !_login;
                          });
                        },
                        child: Text(
                          _login ? "Create new account" : "I have an account",
                          style: const TextStyle(fontSize: 20),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}