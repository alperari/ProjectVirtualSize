import 'file:///D:/AndoidStudio_apps/virtual_size_app/lib/services/AuthService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  String fullname;
  String mail;
  String pass;
  String pass2;
  final _formKey = GlobalKey<FormState>();
  bool success = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[700],
                        filled: true,
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                            color: Colors.grey[200]
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),

                      ),
                      keyboardType: TextInputType.text,

                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter your full-name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        fullname = value;
                      },
                    ),

                  SizedBox(height: 16.0,),

                  TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey[700],
                      filled: true,
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.grey[200]
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter your e-mail';
                      }
                      if(!EmailValidator.validate(value)) {
                        return 'The e-mail address is not valid';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      mail = value;
                    },
                  ),


                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.grey[700],
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.grey[200]
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            //labelText: 'Username',

                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            pass = value;
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            if(value != pass2) {
                              return 'Passwords don\'t match';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),

                      SizedBox(width: 16,),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[700],

                            filled: true,
                            labelText: 'Password (repeat)',
                            labelStyle: TextStyle(
                                color: Colors.grey[200],
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            //labelText: 'Username',

                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            pass2 = value;
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            if(value != pass) {
                              return 'Passwords don\'t match';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () async {

                            if(_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              dynamic result = await _auth.registerWithEmailAndPassword(mail, pass, fullname);

                              if(result == null) {
                                print('Registration failed');
                                setState(() {
                                  success = false;
                                });
                              }
                              else {
                                print('User registered');
                                setState(() {
                                  success = true;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Register was successfull')));
                                Navigator.pop(context);
                              }


                            }

                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(success != true ? "" : "Failed to register")
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
