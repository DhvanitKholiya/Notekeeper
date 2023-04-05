import 'package:flutter/material.dart';
import 'package:notekeeper/helpers/firebase_auth_helper.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              key: formKey,
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
                      decoration:  const InputDecoration(
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
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          Map<String,dynamic>? res = await Firebase_auth_helper
                              .firebase_auth_helper.signIn(email: email, password: password);

                          if (res['user'] != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                              Text("Log In Successful..."),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ));
                            Navigator.of(context).pushReplacementNamed('/');
                          }
                          else {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                              Text("Log In failed..."),
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
                        "Log In",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown.shade500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        "-----------------------OR------------------------"),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> res = await Firebase_auth_helper
                            .firebase_auth_helper
                            .signWithGoogle();

                        if (res['user'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign In successful..."),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.of(context).pushReplacementNamed('/',
                              arguments: res['user']);
                        } else if (res['error'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(res['error']),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown.shade500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              'https://img.freepik.com/free-icon/search_318-265146.jpg',
                              height: 30,
                              width: 30,
                            ),
                            const Text(
                              "Continue With Google",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacementNamed('signUp');
                    }, child: const Text("Create New Account")),
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
