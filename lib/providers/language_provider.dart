import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Languages {
  English,
  Arabic,
  Turkish,
}

class LanguageProvider with ChangeNotifier {
  var currentLang = Languages.English;
  String currentLangText = "english";

  Map<String, Object> textsEn = {
    "settings": "Settings",
    "the_current_lang": "English",
    'email': 'Email',
    "password": "Password",
    "enter_your_password": "Enter your password",
    "enter_your_email": "Enter your email",
    "reset_password": "reset password",
    "reset_password_body":
        "we will send a message to your email to reset your password.\nplease enter your email",
    "forget_password_btn": "forget password ?",
    'submit': "submit",
    'cancel': 'cancel',
    "sign_in": "Sign In",
    "sign_up": "Sign Up",
    "donot_have_account": "Don't have account ",
    "Already_you_have_account": "Already you have account  ",
    "continue_with_google": "Continue With Google   ",
    "continue_with_facebook": "Continue With Facebook",
    "create_new_account": "Create new account ",
    "start": "GET STARTED",
    "Choose_a_lang": "Choose your language.",
    "english": "English",
    "arabic": "العربية",
    "turkish": "Türkçe",
    "theme_app": "Theme",
    "System_default_theme": "System Default Theme",
    "light_theme": "Light Theme",
    "dark_theme": "Dark Theme",
    "primary": "Choose your primary color",
    "accent": "Choose your accent color",
    "choose_a_lang": "language of the app",
    "general_setting": "General Setting",
    "setting": "Setting",
    "color_scheme": "Color Scheme",
    "language": "language",
    'home': 'home',
    'about': 'about',
    "Logout": "LogOut",
    "change_password": "Change Password",
    "notifications": "Notifications",
    "general_settings": "General Settings",
    "accout_settings": "Accout Settings",
    "test_direction": "test_direction",
    "confirm_password": "Confirm Password",
    "enter_your_password_again": "Enter your password again",
    "username": "Username",
    "enter_your_username": "Enter your username",
    "name": "Name",
    "enter_your_name": "Enter your name",
    "phonenumber": "Phone number  (optinal)",
    "enter_your_phonenumber" : "Enter your phone number"
  };

  Map<String, Object> textsAr = {
    "the_current_lang": "العربية",
    "settings": "الإعدادات",
    'home': 'الرئيسية',
    "reset_password": "إعادة تعيين كلمة المرور",
    'email': 'البريد الإلكتروني',
    "password": "كلمة المرور",
    "enter_your_email": "ادخل بريدك الإلكتروني",
    "enter_your_password": "ادخل كلمة المرور",
    "reset_password_body":
        "سنقوم بإرسال رسالة إعاد التعيين الى بريدك الإلكتروني.n/ من فضلك ادخل عنوان بريد الإلكتروني",
    "forget_password_btn": "هل نسيت كلمة المرور ؟",
    'submit': "تأكيد",
    "start": "أبدأ الان",
    'cancel': 'إلغاء',
    "sign_in": "تسجيل الدخول",
    "sign_up": "إنشاء حساب",
    "donot_have_account": "ليس لديك حساب ",
    "Already_you_have_account": "لديك حساب  ",
    "create_new_account": "إنشاء حساب جديد  ",
    "continue_with_google": "المتابعة باستخدام Google   ",
    "continue_with_facebook": "المتابعة باستخدام Facebook",
    "Choose_a_lang": "اختر لغتك",
    "english": "English",
    "arabic": "العربية",
    "turkish": "Türkçe",
    "theme_app": "مظهر التطبيق",
    "theme_screen_title": "قم بتعديل أنماط تطبيقك",
    "theme_mode_title": "أختر مظهر لتطبيقك",
    "System_default_theme": "مظهر الجهاز الافتراضي",
    "light_theme": "المظهر الفاتح",
    "dark_theme": "المظهر الداكن",
    "primary": "أختر اللون الاساسي",
    "accent": "Choose your accent color",
    "choose_a_lang": "لغة التطبيق",
    "general_setting": "عام",
    "setting": "الإعدادات العامة",
    "color_scheme": "نسق الألوان",
    "language": "اللغة",
    'about': "حول التطبيق",
    "Logout": "تسجيل الخروج",
    "change_password": "تغيير كلمة المرور",
    "notifications": "الإشعارات",
    "general_settings": "الإعدادات العامة",
    "accout_settings": "إعدادات الحساب",
    "test_direction": "اختبار الإتحاه",
    "confirm_password": "تأكيد كلمة المرور",
    "enter_your_password_again": "اعد كتابة كلمة المرور",
    "username": "اسم المستخدم",
    "enter_your_username": "ادخل اسم المستخدم الخاص بك",
    "name": "الاسم",
    "enter_your_name": "ادخل اسمك",
    "phonenumber": "رقم الهاتف (اختياري)",
    "enter_your_phonenumber" : "ادخل رقم الهاتف الخاص بك"

  };

  Map<String, Object> textsTr = {
    "the_current_lang": "Türkçe",
    "settings": "Settings",
    'email': 'Email Turkish',
    "password": "Password Turkish",
    "enter_your_password": "Enter your password Turkish",
    "enter_your_email": "Enter your email",
    "reset_password": "reset password",
    "reset_password_body":
        "we will send a message to your email to reset your password.\nplease enter your email",
    "forget_password_btn": "forget password ?",
    'submit': "submit",
    'cancel': 'cancel',
    "sign_in": "Sign In",
    "sign_up": "Sign Up",
    "donot_have_account": "Don't have account Türkçe",
    "Already_you_have_account": "Already you have account  ",
    "continue_with_google": "Continue With Google   ",
    "continue_with_facebook": "Continue With Facebook",
    "create_new_account": "Create new account Türkçe",
    "start": "GET STARTED",
    "Choose_a_lang": "Choose your language.",
    "english": "English",
    "arabic": "Arabic",
    "turkish": "Turkish",
    "theme_app": "Theme",
    "System_default_theme": "System Default Theme",
    "light_theme": "Light Theme",
    "dark_theme": "Dark Theme",
    "primary": "Choose your primary color Türkçe",
    "accent": "Choose your accent color",
    "choose_a_lang": "language of the app",
    "general_setting": "General Setting",
    "setting": "Setting",
    "color_scheme": "Color Scheme Türkçe",
    "language": "language",
    'home': 'home',
    'about': 'about',
    "Logout": "LogOut",
    "change_password": "Change Password",
    "notifications": "Notifications",
    "general_settings": "General Settings",
    "accout_settings": "Accout Settings",
    "test_direction": "test_direction",
    "confirm_password": "submit_password",
    "enter_your_password_again": "Enter your password again",
    "username": "User name",
    "enter_your_username": "enter_your_username",
    "name": "Name",
    "enter_your_name": "Enter your name",
    "enter_your_phonenumber" : "Enter your phone number",
    "phonenumber": "Phone number  (optinal)",


  };

  // changeLan(bool lan) async {
  //   isEn = lan;

  //   notifyListeners();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.setBool("isEn", isEn);
  // }

  void changeLanguage(newLangValue) async {
    currentLang = newLangValue;
    _getlanguageText(currentLang);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("langText", currentLangText);
    print("lang set to sharedprefs as $currentLangText");
  }

  // getLan() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   currentLang = prefs.getBool("isEn") ?? Languages.Arabic;
  //   notifyListeners();
  // }

  Object getTexts(String txt) {
    if (currentLang == Languages.English) {
      return textsEn[txt];
    } else if (currentLang == Languages.Arabic) {
      return textsAr[txt];
    } else if (currentLang == Languages.Turkish) {
      return textsTr[txt];
    }
    return null;
  }

  _getlanguageText(Languages lang) {
    if (lang == Languages.English)
      currentLangText = "en";
    else if (lang == Languages.Arabic)
      currentLangText = "ar";
    else if (lang == Languages.Turkish) currentLangText = "tr";
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLangText = prefs.getString("langText") ?? "en";
    if (currentLangText == "en")
      currentLang = Languages.English;
    else if (currentLangText == "ar")
      currentLang = Languages.Arabic;
    else if (currentLangText == "tr") currentLang = Languages.Turkish;
    notifyListeners();
  }
}
