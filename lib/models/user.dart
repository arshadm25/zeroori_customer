class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String profile;
  final String userType;
  final int noOfJobs;
  final String address;
  final String pincode;
  final String country;
  final String door;
  final String building;
  final String street;
  final String city;

  User(this.id, this.name, this.phone, this.email, this.profile, this.userType,
      this.noOfJobs, this.address, this.pincode, this.country, this.door, this.building, this.street, this.city);

  factory User.fromJson(Map<String, dynamic> js) {
    return User(
      int.parse(js['content']['pk_int_user_id'].toString()),
      js['content']['vchr_name'].toString(),
      js['content']['vchr_phone'].toString(),
      js['content']['vchr_email'].toString(),
      js['content']['vchr_profile'].toString(),
      js['content']['enum_user_type'].toString(),
      int.parse(js['job_number'].toString()),
      js['content']['vchr_customer_address'].toString(),
      js['content']['int_customer_zip'].toString(),
      js['content']['vchr_country'].toString(),
      js['content']['vchr_door_no'].toString(),
      js['content']['vchr_building'].toString(),
      js['content']['vchr_street'].toString(),
      js['content']['vchr_city'].toString(),
    );
  }

  factory User.fromSharePref(Map<String, dynamic> js) {
    return User(
        js['id'],
        js['name'],
        js['phone'],
        js['email'],
        js['profile'],
        js['usertype'],
        js['no_of_jobs'],
        js['address'],
        js['post'],
        js['country'],
        js['door'],
        js['building'],
        js['street'],
        js['city']
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
      'profile': user.profile,
      'usertype': user.userType,
      'no_of_jobs': user.noOfJobs,
      'address': user.address,
      'post': user.pincode,
      'country': user.country,
      'door':user.door,
      'building':user.building,
      'street':user.street,
      'city':user.city,
    };
  }
}
