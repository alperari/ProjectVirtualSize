import 'package:email_validator/email_validator.dart';
import 'file:///D:/AndoidStudio_apps/virtual_size_app/lib/services/AuthService.dart';
import "package:virtual_size_app/Auth/register.dart";
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String mail;
  String pass;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN IN'),
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          style: TextStyle(color:Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.grey,),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: 'E-mail',
                            //labelText: 'Username',

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
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          style: TextStyle(color:Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key_sharp, color: Colors.grey,),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            //labelText: 'Username',

                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
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

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Logging in')));


                              dynamic result = await _auth.signInWithEmailAndPassword(mail, pass);

                              if(result == null) {
                                print('Login failed');
                              }
                              else {
                                print('User logged in');
                              }


                            }

                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(
              height: 24,
              thickness: 2,
            ),



            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text(
                      'Don\'t have an account yet? Register now! -->',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey[300]
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}