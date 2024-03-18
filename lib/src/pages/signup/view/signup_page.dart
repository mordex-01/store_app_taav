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
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: _textFormField(
                    controller: controller.firstNameController,
                    hintText: "Enter your first name",
                    topText: "First Name",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: _textFormField(
                    controller: controller.lastNameController,
                    hintText: "Enter your last name",
                    topText: "Last Name",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            _textFormField(
              controller: controller.userNameController,
              hintText: "Enter your user name",
              topText: "User Name",
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill this field";
                }
                return null;
              },
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: _textFormField(
                    controller: controller.passwordController,
                    hintText: "Enter your password",
                    topText: "Password",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: _textFormField(
                    controller: controller.confirmPasswordController,
                    hintText: "Confirm password",
                    topText: "Confirm Password",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: _radioListTile(
                      title: controller.radioOptions[0],
                      value: controller.radioOptions[0],
                      currentValue: controller.radioCurrentOption.value,
                      onChanged: (value) {
                        controller.radioCurrentOption.value = value.toString();
                      },
                    ),
                  ),
                  Expanded(
                    child: _radioListTile(
                      title: controller.radioOptions[1],
                      value: controller.radioOptions[1],
                      currentValue: controller.radioCurrentOption.value,
                      onChanged: (value) {
                        controller.radioCurrentOption.value = value.toString();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: _button(
                context: context,
                text: "Sign Up",
                onTap: () {
                  controller.onSignUpTapped();
                },
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _radioListTile({
    required String title,
    required String value,
    required String currentValue,
    required void Function(String?)? onChanged,
  }) =>
      ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        leading: Radio(
          activeColor: WidgetUtils.darkBlue,
          value: value,
          groupValue: currentValue,
          onChanged: onChanged,
        ),
      );
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
          required String? Function(String?)? validator,
          TextEditingController? controller}) =>
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextFormField(
              controller: controller,
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
  Widget _button(
          {required BuildContext context,
          required String text,
          required void Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 35,
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
}
