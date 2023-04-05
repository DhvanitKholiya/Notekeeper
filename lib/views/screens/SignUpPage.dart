import 'package:flutter/material.dart';

import '../../helpers/firebase_auth_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formPageKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'Assets/My_Images/Screenshot_37-removebg-preview.png',
            height: 100,
            width: 100,
          ),
          Image.network(
            'https://cdn.iconscout.com/icon/free/png-256/firebase-3628772-3030134.png',
            fit: BoxFit.scaleDown,
            color: Colors.orange.withOpacity(0.2),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.white.withOpacity(0.5),
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formPageKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter first your email";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = emailController.text;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Email",
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.brown),
                      ),
                      textInputAction: TextInputAction.next,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter first your password";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          password = passwordController.text;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                      ),
                      textInputAction: TextInputAction.done,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (formPageKey.currentState!.validate()) {
                          formPageKey.currentState!.save();

                          Map<String, dynamic>? res = await Firebase_auth_helper
                              .firebase_auth_helper
                              .signUp(email: email, password: password);

                          if (res['user'] != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Sign Up Successful..."),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ));
                            Navigator.of(context).pushReplacementNamed('login',
                                arguments: res['user']);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Sign Up failed..."),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown.shade500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
