import 'Service.dart';

enum OrderStatus{
  ALL,
  NEW,
  PROGRESS,
  COMPLETED
}
class Order{
  final int id;
  final Service service;
  final String estimatedDate;
  final String status;
  final String area;
  final String prefferedTime;
  final String description;
  final String typeOfService;
  final String unitType;
  final String phone;
  final List<String> images;
  final String location;

  Order(this.id, this.service, this.estimatedDate, this.status, this.area, this.prefferedTime, this.description, this.typeOfService, this.unitType, this.phone, this.images, this.location);
}