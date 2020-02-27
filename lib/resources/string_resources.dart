class StringResources{
  static const String loginToContinue = "Login to continue to your account";
  static const String welcome = "Welcome!";
  static const String signIn = "Sign In";
  static const String signUp = "Sign Up";
  static const String email = "Email";
  static const String password = "Password";
  static const String clickHere = "Click Here";
  static const String forgotPassword = "Forgot your Password";
  static const String oops = "Oops!";
  static const String ok = "Ok!";
  static const String phone = "Phone";
  static const String firstName = "Firt Name";
  static const String name = "Name";
  static const String lastName = "Last Name";
  static const String addresss = "Address";
  static const String country = "Country";
  static const String postal = "Postcode/Zip";


  static const String pleaseEnterFirstName = "Please enter your first name";
  static const String pleaseEnterLastName = "Please enter your last name";
  static const String pleaseEnterPhone = "Please enter your phone";
  static const String pleaseEnterValidPhone = "Please enter valid phone";
  static const String pleaseEnterYourEmail = "Please enter your email";
  static const String pleaseEnterValidEmail = "Please enter your valid email";
  static const String pleaseEnterYourPassword = "Please enter your password";
  static const String pleaseEnterValidPassword = "Please enter valid password";
  static const String pleaseEnterPasswordMinimum8 = "Please enter password with minimum 8 letters";
  static const String pleaseEnterAddress = "Please enter your address";
  static const String pleaseEnterCountry = "Please enter your country";
  static const String pleaseEnterPostal = "Please enter your postal code";

  static const String pleaseSelectImage = "Please choose a valid image";
  static const String pleaseFillAllFields = "Please enter all fields";
}

class RouteNames{
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
}
class PatterStrings{
  static const Pattern email = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const Pattern phone = r'^(?:[+0]9)?[0-9]{10}$';
}

class UrlResources{
  static const String baseUrl = "http://192.168.0.15/zeroori/Customer_side_api/";

  static const String loginUrl  = baseUrl + "customer_login";
  static const String registerUrl = baseUrl + "customer_registration";
}

class SharedResources{
  static const String IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String USER = "USER";
  static const String USER_ID = "USER_ID";
}