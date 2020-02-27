class User{
  final int id;
  final String name;
  final String phone;
  final String email;
  final String profile;
  final String userType;
  final int noOfJobs;

  User(this.id, this.name, this.phone, this.email, this.profile, this.userType, this.noOfJobs);

  factory User.fromJson(Map<String,dynamic> js){
    return User(
      int.parse(js['content']['pk_int_user_id'].toString()),
      js['content']['vchr_name'].toString(),
      js['content']['vchr_phone'].toString(),
      js['content']['vchr_email'].toString(),
      js['content']['vchr_profile'].toString(),
      js['content']['enum_user_type'].toString(),
      int.parse(js['job_number'].toString())
    );
  }

  factory User.fromSharePref(Map<String,dynamic> js){
    return User(
        js['id'],
        js['name'],
        js['phone'],
        js['email'],
        js['profile'],
        js['usertype'],
        js['no_of_jobs']
    );
  }

  static Map<String,dynamic> toJson(User user){
    return {
      'id':user.id,
      'name':user.name,
      'phone':user.phone,
      'email':user.email,
      'profile':user.profile,
      'usertype':user.userType,
      'no_of_jobs':user.noOfJobs
    };
  }
}