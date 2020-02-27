import 'package:zeroori_customer/models/Service.dart';
import 'package:zeroori_customer/models/order.dart';

enum Status{
  IN_PROGRESS,
  COMPLETED,
  CANCELLED
}
class StatusConverter{
  getStatus(String status){
    switch(status){
      case "Processing":
        return Status.IN_PROGRESS;
      case "Completed":
        return Status.COMPLETED;
      case "cancelled":
        return Status.CANCELLED;
    }
  }
}
class OrderService{
  static Future<List<Order>> getOrders(int userId,OrderStatus status) async {
    return Future.value( [
      Order(
          1,
          Service(
            1,
            "AC Works",
            "assets/wood.jpg",
            "asdf",
          ),
          "23/10/2019",
          "In Progress",
          "area",
          "preffered Time",
          "description",
          "type of service",
          "unit type",
          "9995242392",
          [
            "asdf",
            "asdfadsf",
          ],
          "location"
      ),
      Order(
          1,
          Service(
            1,
            "AC Works",
            "assets/wood.jpg",
            "asdf",
          ),
          "23/10/2019",
          "In Progress",
          "area",
          "preffered Time",
          "description",
          "type of service",
          "unit type",
          "9995242392",
          [
            "asdf",
            "asdfadsf",
          ],
          "location"
      ),
      Order(
          1,
          Service(
            1,
            "AC Works",
            "assets/wood.jpg",
            "asdf",
          ),
          "23/10/2019",
          "In Progress",
          "area",
          "preffered Time",
          "description",
          "type of service",
          "unit type",
          "9995242392",
          [
            "asdf",
            "asdfadsf",
          ],
          "location"
      ),
      Order(
          1,
          Service(
            1,
            "AC Works",
            "assets/wood.jpg",
            "asdf",
          ),
          "23/10/2019",
          "In Progress",
          "area",
          "preffered Time",
          "description",
          "type of service",
          "unit type",
          "9995242392",
          [
            "asdf",
            "asdfadsf",
          ],
          "location"
      ),
      Order(
          1,
          Service(
            1,
            "AC Works",
            "assets/wood.jpg",
            "asdf",
          ),
          "23/10/2019",
          "In Progress",
          "area",
          "preffered Time",
          "description",
          "type of service",
          "unit type",
          "9995242392",
          [
            "asdf",
            "asdfadsf",
          ],
          "location"
      )
    ]);
  }
}