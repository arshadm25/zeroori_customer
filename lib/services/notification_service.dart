import 'package:zeroori_customer/models/notifications.dart';

class NotificationService{
  static List<Notifications> getNotifications(int userId){
    return List.generate(10,  (index)=>Notifications(
        index,
        "Order #11360 is sent to all service provider. We will notify you by any new offer",
        "2019-10-03, 10:18:15"
    ));
  }
}