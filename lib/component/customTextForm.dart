import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController myController;
  const CustomTextFormSign(
      {Key? key, required this.hint, required this.myController, required this.valid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: myController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            hintText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
