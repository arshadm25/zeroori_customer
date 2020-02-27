class Notifications{
  final int id;
  final String notification;
//  final String image;
  final String notifiedOn;

  Notifications(this.id, this.notification, this.notifiedOn);

  factory Notifications.fromJson(Map<String,dynamic> js){
    return Notifications(
      js['pk_int_notification_id'],
      js['text_message'],
      js['vchr_notification_date'],

    );
  }
}