



import 'dart:convert';

RestuarentModel welcomeFromJson(String str) => RestuarentModel.fromJson(json.decode(str));

String welcomeToJson(RestuarentModel data) => json.encode(data.toJson());

class RestuarentModel {
  RestuarentModel({
    this.data,
  });

  List<Datum> data;

  factory RestuarentModel.fromJson(Map<String, dynamic> json) => RestuarentModel(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.restid,
    this.name,
    this.cuisinid,
    this.cuisine,
    this.address,
    this.city,
    this.state,
    this.distance,
    this.deliverytime,
    this.reviews,
    this.logo,
    this.cover,
    this.acceptorders,
    this.isOpen,
  });

  int restid;
  String name;
  int cuisinid;
  String cuisine;
  String address;
  String city;
  String state;
  int distance;
  int deliverytime;
  String reviews;
  String logo;
  String cover;
  int acceptorders;
  int isOpen;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    restid: json["restid"],
    name: json["name"],
    cuisinid: json["cuisinid"],
    cuisine: json["cuisine"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    distance: json["distance"],
    deliverytime: json["deliverytime"],
    reviews: json["reviews"],
    logo: json["logo"] == null ? null : json["logo"],
    cover: json["cover"] == null ? null : json["cover"],
    acceptorders: json["acceptorders"],
    isOpen: json["isOpen"],
  );

  Map<String, dynamic> toJson() => {
    "restid": restid,
    "name": name,
    "cuisinid": cuisinid,
    "cuisine": cuisine,
    "address": address,
    "city":city,
    "state": state,
    "distance": distance,
    "deliverytime": deliverytime,
    "reviews": reviews,
    "logo": logo == null ? null : logo,
    "cover": cover == null ? null : cover,
    "acceptorders": acceptorders,
    "isOpen": isOpen,
  };
}

