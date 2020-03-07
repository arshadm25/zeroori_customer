class StringResources {
  static const String loginToContinue = "Login to continue to your account";
  static const String welcome = "Welcome!";
  static const String signIn = "Sign In";
  static const String signUp = "Sign Up";
  static const String email = "Email";
  static const String password = "Password";
  static const String clickHere = "Click Here";
  static const String forgotYourPassword = "Forgot your Password";
  static const String oops = "Oops!";
  static const String ok = "Ok!";
  static const String phone = "Phone";
  static const String firstName = "Firt Name";
  static const String name = "Name";
  static const String lastName = "Last Name";
  static const String addresss = "Address";
  static const String country = "Country";
  static const String postal = "Postcode/Zip";

  static const String doorNo = "Door No.";
  static const String building = "Building";
  static const String street = "Street";
  static const String city = "City";

  static const String subCategory = 'Sub Category';
  static const String selectSubCategory = 'Select Sub Category';
  static const String noSubCategoryFound = "No Sub Category found";
  static const String services = "Services";
  static const String myOrders = "My Orders";
  static const String more = "More";
  static const String submit = "Submit";
  static const String success = "Success";
  static const String exception = "Exception: ";
  static const String emptyString = "";
  static const String otp = "OTP";
  static const String enterOtp = "Enter Otp";
  static const String enterOtpToContinue = "Enter otp to continue";
  static const String forgotPassword = "Forgot Password";
  static const String enterYourEmailToContinue = "Enter your email to continue";
  static const String userRegisteredSuccessfully =
      "User registered successfully";
  static const String resetPassword = "Reset Password";
  static const String newPassword = "New Password";
  static const String confirmPassword = "Confirm Password";

  static const String pleaseEnterFirstName = "Please enter your first name";
  static const String pleaseEnterLastName = "Please enter your last name";
  static const String pleaseEnterPhone = "Please enter your phone";
  static const String pleaseEnterValidPhone = "Please enter valid phone";
  static const String pleaseEnterYourEmail = "Please enter your email";
  static const String pleaseEnterValidEmail = "Please enter your valid email";
  static const String pleaseEnterYourPassword = "Please enter your password";
  static const String pleaseEnterValidPassword = "Please enter valid password";
  static const String pleaseEnterPasswordMinimum8 =
      "Please enter password with minimum 8 letters";
  static const String pleaseEnterAddress = "Please enter your address";
  static const String pleaseEnterCountry = "Please enter your country";
  static const String pleaseEnterPostal = "Please enter your postal code";
  static const String pleaseEnterOtp = "Please enter your otp";
  static const String pleaseEnterBuilding = "Please enter your building no. or name";
  static const String pleaseEnterDoorNo = "Please enter your Door No.";
  static const String pleaseEnterCity = "Please enter your City";
  static const String pleaseEnterStreet = "Please enter your Street";

  static const String pleaseSelectImage = "Please choose a valid image";
  static const String pleaseFillAllFields = "Please enter all fields";
  static const String passwordConfirmPasswordMismatch =
      "New Password and confirm password mismatch";
}

class RouteNames {
  static const String frontPage = 'front_page';
  static const String loginPage = 'login';
  static const String registerPage = 'register';
  static const String forgotPage = 'forgot';
  static const String changePasswordPage = 'change_password';
  static const String servicePage = 'services';
  static const String notificationPage = 'notification';
  static const String subCategoryPage = 'sub_category';
  static const String myOrdersPage = 'my_orders';
  static const String fillOrderPage = 'fill_order';
  static const String selectAreaPage = 'select_area';
  static const String selectMapPage = 'select_map';
  static const String describeProblemPage = 'describe_problem';
  static const String selectDatePage = 'select_date';
  static const String selectImagePage = 'select_image';
  static const String confirmPage = 'confirm';
  static const String myProfilePage = 'my_profile';
  static const String orderDetailsPage = 'order_details';
  static const String reportPage = 'report';
  static const String offerPage = 'offer';
  static const String editPage = 'edit';
  static const String lagnuagePage = 'language';
  static const String emailPage = 'email';
  static const String aboutPage = 'about';
  static const String resetPage = 'reset';
  static const String otpPage = 'otp';
}

class PatterStrings {
  static const Pattern email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const Pattern phone = r'^(?:[+0]9)?[0-9]{10}$';
}

class UrlResources {
  static const String mainUrl = "http://192.168.1.8/zeroori/";
  static const String baseUrl = "http://192.168.1.8/zeroori/Customer_side_api/";
//  static const String mainUrl = "http://xianinfotech.in/zer/";
//  static const String baseUrl = "http://xianinfotech.in/zer/Customer_side_api/";

  static const String loginUrl = baseUrl + "customer_login";
  static const String registerUrl = baseUrl + "customer_registration";
  static const String sliders = baseUrl + "displaySlider";
  static const String services = baseUrl + "category_list";
  static const String sub_services = baseUrl + "sub_category_list";
  static const String forgot_pass = baseUrl + "forget_password_add_email";
  static const String enter_otp = baseUrl + "enter_otp";

  static const String reset_pass = baseUrl + "forget_pasword_change";
  static const String notification_list = baseUrl + "display_notification_list";
  static const String orders = baseUrl + "order_list_for_user_id";
  static const String create_order = baseUrl + "add_job";
  static const String confirm_order = baseUrl + "changeOrderStatus";
  static const String email_us = baseUrl + "email_us";
  static const String report_us = baseUrl + "report_us";
  static const String update_user = baseUrl + "update_customer";
}

class SharedResources {
  static const String IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String USER = "USER";
  static const String USER_ID = "USER_ID";
}
