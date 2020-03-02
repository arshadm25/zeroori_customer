class Notifications{
  final int id;
  final String notification;
//  final String image;
  final String notifiedOn;

  Notifications(this.id, this.notification, this.notifiedOn);

  factory Notifications.fromJson(Map<String,dynamic> js){
    return Notifications(
      int.parse(js['pk_int_notification_id'].toString()),
      js['text_message'].toString(),
      js['vchr_notificaton_date'],
    );
  }
}