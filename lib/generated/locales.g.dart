// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// ignore_for_file: lines_longer_than_80_chars
// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';

class AppTranslation extends Translations {
  // static Map<String, Map<String, String>> translations = {
  //   'en_US': Locales.en_US,
  //   'fa_IR': Locales.fa_IR,
  // };

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': Locales.en_US,
        'fa_IR': Locales.fa_IR,
      };
}

class LocaleKeys {
  LocaleKeys._();
  static const login = 'login';
  static const signUp = 'signUp';
  static const signInToContinue = 'signInToContinue';
  static const loginUserName = 'loginUserName';
}

class Locales {
  static const en_US = {
    'login': 'Login',
    'signUp': 'signUp',
    'signInToContinue': 'Sign In to continue',
    'loginUserName': 'User Name',
  };
  static const fa_IR = {
    'login': 'ورود',
    'signUp': 'ثبت نام',
    'signInToContinue': 'برای ادامه وارد شوید',
    'loginUserName': 'نام کاربری',
  };
}
