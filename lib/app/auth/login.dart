import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phpfluttercourse/component/crud.dart';
import 'package:phpfluttercourse/component/customTextForm.dart';
import 'package:phpfluttercourse/component/valid.dart';
import 'package:phpfluttercourse/constant/linkapi.dart';
import 'package:phpfluttercourse/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formState = GlobalKey();

  Crud crud = Crud();

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10),
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView(
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
                          hint: "email",
                          myController: emailController),
                      CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          hint: "password",
                          myController: passwordController),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await Login();
                        },
                        child: const Text("Login"),
                      ),
                      Container(height: 10),
                      InkWell(
                        child: const Text("Sign Up"),
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    ));
  }

  Login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        "email": emailController.text,
        "password": passwordController.text,
      });

      isLoading = true;
      setState(() {});
      if (response['status'] == "success") {
        sharedP.setString("id", response['data']['id'].toString());
        sharedP.setString("username", response['data']['username']);
        sharedP.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
                context: context,
                title: "Alert",
                body: const Text(
                    "your email or password is wrong or you have not an account !"))
            .show();
      }
    }
  }
}
