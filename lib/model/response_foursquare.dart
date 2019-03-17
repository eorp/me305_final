// To parse this JSON data, do
//
//     final responseFoursquare = responseFoursquareFromJson(jsonString);

import 'dart:convert';

ResponseFoursquare responseFoursquareFromJson(String str) {
  final jsonData = json.decode(str);
  return ResponseFoursquare.fromJson(jsonData);
}

String responseFoursquareToJson(ResponseFoursquare data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ResponseFoursquare {
  Meta meta;
  Response response;

  ResponseFoursquare({
    this.meta,
    this.response,
  });

  factory ResponseFoursquare.fromJson(Map<String, dynamic> json) => new ResponseFoursquare(
    meta: Meta.fromJson(json["meta"]),
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "response": response.toJson(),
  };
}

class Meta {
  int code;
  String requestId;

  Meta({
    this.code,
    this.requestId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => new Meta(
    code: json["code"],
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "requestId": requestId,
  };
}

class Response {
  List<Venue> venues;
  bool confident;

  Response({
    this.venues,
    this.confident,
  });

  factory Response.fromJson(Map<String, dynamic> json) => new Response(
    venues: new List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
    confident: json["confident"],
  );

  Map<String, dynamic> toJson() => {
    "venues": new List<dynamic>.from(venues.map((x) => x.toJson())),
    "confident": confident,
  };
}

class Venue {
  String id;
  String name;
  Location location;
  List<Category> categories;
  String referralId;
  bool hasPerk;

  Venue({
    this.id,
    this.name,
    this.location,
    this.categories,
    this.referralId,
    this.hasPerk,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => new Venue(
    id: json["id"],
    name: json["name"],
    location: Location.fromJson(json["location"]),
    categories: new List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    referralId: json["referralId"],
    hasPerk: json["hasPerk"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location.toJson(),
    "categories": new List<dynamic>.from(categories.map((x) => x.toJson())),
    "referralId": referralId,
    "hasPerk": hasPerk,
  };

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, location: $location, categories: $categories, referralId: $referralId, hasPerk: $hasPerk}';
  }

}

class Category {
  String id;
  String name;
  String pluralName;
  String shortName;
  Icon icon;
  bool primary;

  Category({
    this.id,
    this.name,
    this.pluralName,
    this.shortName,
    this.icon,
    this.primary,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
    id: json["id"],
    name: json["name"],
    pluralName: json["pluralName"],
    shortName: json["shortName"],
    icon: Icon.fromJson(json["icon"]),
    primary: json["primary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pluralName": pluralName,
    "shortName": shortName,
    "icon": icon.toJson(),
    "primary": primary,
  };
}

class Icon {
  String prefix;
  String suffix;

  Icon({
    this.prefix,
    this.suffix,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => new Icon(
    prefix: json["prefix"],
    suffix: json["suffix"],
  );

  Map<String, dynamic> toJson() => {
    "prefix": prefix,
    "suffix": suffix,
  };
}

class Location {
  String address;
  double lat;
  double lng;
  List<LabeledLatLng> labeledLatLngs;
  int distance;
  String postalCode;
  String cc;
  String city;
  String state;
  String country;
  List<String> formattedAddress;

  Location({
    this.address,
    this.lat,
    this.lng,
    this.labeledLatLngs,
    this.distance,
    this.postalCode,
    this.cc,
    this.city,
    this.state,
    this.country,
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => new Location(
    address: json["address"] == null ? null : json["address"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    labeledLatLngs: new List<LabeledLatLng>.from(json["labeledLatLngs"].map((x) => LabeledLatLng.fromJson(x))),
    distance: json["distance"],
    postalCode: json["postalCode"] == null ? null : json["postalCode"],
    cc: json["cc"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"],
    formattedAddress: new List<String>.from(json["formattedAddress"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "lat": lat,
    "lng": lng,
    "labeledLatLngs": new List<dynamic>.from(labeledLatLngs.map((x) => x.toJson())),
    "distance": distance,
    "postalCode": postalCode == null ? null : postalCode,
    "cc": cc,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "country": country,
    "formattedAddress": new List<dynamic>.from(formattedAddress.map((x) => x)),
  };

  @override
  String toString() {
    return 'Location{address: $address, lat: $lat, lng: $lng, labeledLatLngs: $labeledLatLngs, distance: $distance, postalCode: $postalCode, cc: $cc, city: $city, state: $state, country: $country, formattedAddress: $formattedAddress}';
  }


}

class LabeledLatLng {
  String label;
  double lat;
  double lng;

  LabeledLatLng({
    this.label,
    this.lat,
    this.lng,
  });

  factory LabeledLatLng.fromJson(Map<String, dynamic> json) => new LabeledLatLng(
    label: json["label"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "lat": lat,
    "lng": lng,
  };
}
