import 'package:flutter/material.dart';

import '../crud/crud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  CrudOperation crudOperation = CrudOperation();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "It's a Brew Day",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.red),
                    ),
                  ),
                  const Text(
                    "Please, Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          crudOperation
                              .signInWithEmail(
                                  _emailController.text, _passwordController.text)
                              .then((value) {
                            Navigator.of(context).pushReplacementNamed('/recipe');
                          }).catchError((error) {
                            if (error.toString().contains('invalid-email')) {
                              const SnackBar(content: Text('Invalid-email'));
                            } else if (error
                                .toString()
                                .contains('user-not-found')) {
                              const SnackBar(content: Text('User-not-found'));
                            } else if (error
                                .toString()
                                .contains('wrong-password')) {
                              const SnackBar(content: Text('Wrong-password'));
                            } else {
                              const SnackBar(
                                  content:
                                      Text('Ooops Unexpected Error happened'));
                            }
                          }).whenComplete(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Welcome Back')),
                            );
                          });
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          textStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/register');
                        },
                        child: const Text('REGISTER'),
                      ),

                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
