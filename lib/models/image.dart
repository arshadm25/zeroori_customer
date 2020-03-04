class ServiceImage {
  final int id;
  final String image;

  ServiceImage(this.id, this.image);

  factory ServiceImage.fromJson(Map<String, dynamic> js) {
    return ServiceImage(
      int.parse(js['pk_int_job_image_id'].toString()),
      js['vchr_job_image'].toString(),
    );
  }
}
