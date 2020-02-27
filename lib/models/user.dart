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
      js['content']['pk_int_user_id'],
      js['content']['vchr_name'],
      js['content']['vchr_phone'],
      js['content']['vchr_email'],
      js['content']['vchr_profile'],
      js['content']['enum_user_type'],
      js['job_number']
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