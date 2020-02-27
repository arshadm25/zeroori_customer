class Service{
  final int id;
  final String name;
  final String image;
  final String description;

  Service(this.id, this.name, this.image,this.description);

  factory Service.fromJson(Map<String,dynamic> js){
    return Service(
      js['pk_int_category_id'],
        js['vchr_category_name'].toString(),
      js['vchr_category_description'].toString(),
      js['vchr_category_description'].toString(),
    );
  }


}