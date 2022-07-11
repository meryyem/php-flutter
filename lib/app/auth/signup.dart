import 'package:flutter/material.dart';
import 'package:phpfluttercourse/component/customTextForm.dart';
import 'package:phpfluttercourse/component/valid.dart';
import 'package:phpfluttercourse/constant/linkapi.dart';

import '../../component/crud.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState = GlobalKey();
  Crud _crud = Crud();

  bool isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil("success", (route) => false);
        //Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        print("Sign Up Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset("assets/images/logo.jpg",
                            width: 200, height: 200),
                        CustomTextFormSign(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            hint: "username",
                            myController: usernameController),
                        CustomTextFormSign(
                            valid: (val) {
                              return validInput(val!, 5, 40);
                            },
                            hint: "email",
                            myController: emailController),
                        CustomTextFormSign(
                            valid: (val) {
                              return validInput(val!, 3, 10);
                            },
                            hint: "password",
                            myController: passwordController),
                        MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await signUp();
                          },
                          child: const Text("SignUp"),
                        ),
                        Container(height: 10),
                        InkWell(
                          child: const Text("Login"),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed("login");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
