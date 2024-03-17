import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const Expanded(
                flex: 5,
                child: SizedBox(),
              ),
              _lockIcon(),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              _signInText(),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              _textFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill this field";
                  }
                  return null;
                },
                obscureText: false,
                topText: "User Name",
                hintText: "Enter Your User Name",
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ),
              Obx(
                () => _textFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill this field";
                    }
                    return null;
                  },
                  obscureText: !controller.isObscure.value,
                  topText: "Password",
                  hintText: "Enter Your Password",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () => controller.toggleObscure(),
                      icon: Icon(
                        controller.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off_sharp,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => _rememberMe(
                  iconColor: !controller.isRememberMeCheck.value
                      ? WidgetUtils.blueAcentColor
                      : WidgetUtils.darkBlue,
                  icon: !controller.isRememberMeCheck.value
                      ? Icons.check_box_outline_blank
                      : Icons.check_box_rounded,
                  onPressed: () => controller.toggleIsRememberMe(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: _button(
                  context: context,
                  text: "Login",
                  onTap: () {
                    controller.onLoginTapped();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _mydivider(context: context),
              ),
              const Text(
                "Dont have any account?",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _button(
                  context: context,
                  text: "Sign Up",
                  onTap: () {
                    controller.onSignUpTapped();
                  },
                ),
              ),
              const Expanded(
                flex: 10,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lockIcon() => const Icon(
        Icons.lock,
        size: 96,
        color: WidgetUtils.blueAcentColor,
      );
  Widget _signInText() => const Text(
        "Sign In to continue",
        style: TextStyle(fontSize: 24),
      );
  Widget _textFormField(
          {required String hintText,
          required Widget suffixIcon,
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
                suffixIcon: suffixIcon,
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
  Widget _rememberMe(
          {required IconData icon,
          required void Function() onPressed,
          required Color iconColor}) =>
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 35,
                color: iconColor,
              ),
            ),
            const Text(
              "Remember Me",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      );
  Widget _button(
          {required BuildContext context,
          required String text,
          required void Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 54,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: WidgetUtils.blueAcentColor),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      );
  Widget _mydivider({required BuildContext context}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.5,
            child: const Divider(
              color: WidgetUtils.darkBlue,
            ),
          ),
          const Text(
            "OR",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.5,
            child: const Divider(
              color: WidgetUtils.darkBlue,
            ),
          ),
        ],
      );
}
