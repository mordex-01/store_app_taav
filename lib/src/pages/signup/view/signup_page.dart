import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/signup/controller/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: WidgetUtils.arrowBackButton,
        ),
      ),
      body: Column(
        children: [
          _textFormField(
            hintText: "Enter your first name",
            topText: "First Name",
            obscureText: false,
            validator: (p0) {},
          ),
          _textFormField(
            hintText: "Enter your last name",
            topText: "Last Name",
            obscureText: false,
            validator: (p0) {},
          ),
          _textFormField(
            hintText: "Enter your user name",
            topText: "User Name",
            obscureText: false,
            validator: (p0) {},
          ),
          _textFormField(
            hintText: "Enter your password",
            topText: "Password",
            obscureText: false,
            validator: (p0) {},
          ),
          _textFormField(
            hintText: "Confirm password",
            topText: "Confirm Password",
            obscureText: false,
            validator: (p0) {},
          ),
        ],
      ),
    );
  }

  Widget _appBarTitle() => const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Create  New Account",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.person_add,
              size: 30,
            ),
          )
        ],
      );
  Widget _textFormField(
          {required String hintText,
          required String topText,
          required bool obscureText,
          required String? Function(String?)? validator}) =>
      Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                topText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextFormField(
              maxLength: 20,
              validator: validator,
              obscureText: obscureText,
              decoration: InputDecoration(
                counterText: "",
                hintText: hintText,
                suffixIconColor: WidgetUtils.blueAcentColor,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: WidgetUtils.blueAcentColor,
                    width: 2,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ],
        ),
      );
}
