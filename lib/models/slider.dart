class Slider{
  final int id;
  final String image;

  Slider(this.id, this.image,);

  factory Slider.fromJson(Map<String,dynamic> js){
    return Slider(
      js['pk_int_slider_id'],
      js['image'],
    );
  }
}