import 'package:flutter/material.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authService = Provider.of<AuthenticationService>(context);
    var userService = Provider.of<UserProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            // ignore: use_build_context_synchronously
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => RegisterPage()));
            var ok = await authService.signIn(
                email: emailController.text, password: passwordController.text);
            if (ok) {
              userService.loadUser();
              Navigator.pushReplacementNamed(context, '/main');
            } else {
              // ignore: use_build_context_synchronously
              // ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Error al iniciar sesión')));
            }
          },
          child: const Text('Sign Up'),
        ),
        body: Stack(
          children: [
            // ClipPath(
            //   clipper: BottomCurveClipper(),
            //   child: Container(
            //     height: size.height * .95,
            //     color: Colors.white,
            //   ),
            // ),
            Positioned(
              top: kToolbarHeight + 20,
              left: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    const Text("Continue with\nyour email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text("Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,

                        hintText: "Enter your email",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        //remove all borders
                        //add border radius around textfield
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        //add rounded corners to textfield
                        //borderRadius: BorderRadius.circular(50),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter your password",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        //remove all borders
                        //add border radius around textfield
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        //add rounded corners to textfield
                        //borderRadius: BorderRadius.circular(50),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //richtext
                    GestureDetector(
                      onTap: () {
                        // ignore: use_build_context_synchronously
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => RegisterPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: SizedBox(
                          width: size.width * 0.5,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Create an account?\n",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ])),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
