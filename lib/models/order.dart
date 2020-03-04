import 'package:zeroori_customer/services/order_services.dart';

import 'Service.dart';

class Order {
  final int id;
  final Service service;
  final String estimatedDate;
  final OrderStatus status;
  final String area;
  final String prefferedTime;
  final String description;
  final String address;

//  final String typeOfService;
//  final String unitType;
  final String phone;
  final List<dynamic> images;
  final String location;

  Order(
      this.id,
      this.service,
      this.estimatedDate,
      this.status,
      this.area,
      this.prefferedTime,
      this.description,
//    this.typeOfService,
//    this.unitType,
      this.phone,
      this.images,
      this.location,
      this.address);

  factory Order.fromJson(Map<String, dynamic> js) {
    return Order(
      int.parse(js["pk_int_job_id"].toString()),
      Service.fromJson(js),
      js["vchr_estimated_date"],
      StatusConverter().setStatus(js["vchr_order_status"]),
      js["vchr_job_area"],
      (DateTime.parse(js["vchr_date_from"]).day.toString() +
              "/" +
              DateTime.parse(js["vchr_date_from"]).month.toString() +
              "/" +
              DateTime.parse(js["vchr_date_from"]).year.toString()) +
          " - " +
          (DateTime.parse(js["vchr_date_to"]).day.toString() +
              "/" +
              DateTime.parse(js["vchr_date_to"]).month.toString() +
              "/" +
              DateTime.parse(js["vchr_date_to"]).year.toString()),
      js["vchr_job_description"],
      js["vchr_phone"],
      js["images"],
      //.map((v)=>ServiceImage.fromJson(v)).toList(),
      js["vchr_geo_location"],
      js['vchr_address'],
    );
  }
}
