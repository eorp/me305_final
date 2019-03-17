// To parse this JSON data, do
//
//     final responseDepartures = responseDeparturesFromJson(jsonString);

import 'dart:convert';

ResponseDepartures responseDeparturesFromJson(String str) {
  final jsonData = json.decode(str);
  return ResponseDepartures.fromJson(jsonData);
}

String responseDeparturesToJson(ResponseDepartures data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ResponseDepartures {
  StationD station;

  ResponseDepartures({
    this.station,
  });

  factory ResponseDepartures.fromJson(Map<String, dynamic> json) => new ResponseDepartures(
    station: StationD.fromJson(json["station"]),
  );

  Map<String, dynamic> toJson() => {
    "station": station.toJson(),
  };
}

class StationD {
  String id;
  String name;
  String code;
  String slug;
  String lat;
  String lng;
  Transfers transfers;

  StationD({
    this.id,
    this.name,
    this.code,
    this.slug,
    this.lat,
    this.lng,
    this.transfers,
  });

  factory StationD.fromJson(Map<String, dynamic> json) => new StationD(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    slug: json["slug"],
    lat: json["lat"],
    lng: json["lng"],
    transfers: Transfers.fromJson(json["transfers"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "slug": slug,
    "lat": lat,
    "lng": lng,
    "transfers": transfers.toJson(),
  };
}

class Transfers {
  List<Transfer> transfer;

  Transfers({
    this.transfer,
  });

  factory Transfers.fromJson(Map<String, dynamic> json) => new Transfers(
    transfer: new List<Transfer>.from(json["transfer"].map((x) => Transfer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transfer": new List<dynamic>.from(transfer.map((x) => x.toJson())),
  };
}

class Transfer {
  String id;
  String departure;
  dynamic newDeparture;
  String destination;
  String track;
  String train;
  String type;
  //Type type;
  String comment;
  String detected;
  String updated;

  Transfer({
    this.id,
    this.departure,
    this.newDeparture,
    this.destination,
    this.track,
    this.train,
    this.type,
    this.comment,
    this.detected,
    this.updated,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => new Transfer(
    id: json["id"],
    departure: json["departure"],
    newDeparture: json["newDeparture"],
    destination: json["destination"],
    track: json["track"],
    train: json["train"],
    type: json["type"],
    //type: typeValues.map[json["type"]],
    comment: json["comment"] == null ? null : json["comment"],
    detected: json["detected"],
    updated: json["updated"] == null ? null : json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "departure": departure,
    "newDeparture": newDeparture,
    "destination": destination,
    "track": track,
    "train": train,
    "type": type,//typeValues.reverse[type],
    "comment": comment == null ? null : comment,
    "detected": detected,
    "updated": updated == null ? null : updated,
  };

  @override
  String toString() {
    return 'Transfer{id: $id, departure: $departure, newDeparture: $newDeparture, destination: $destination, track: $track, train: $train, type: $type, comment: $comment, detected: $detected, updated: $updated}';
  }

}

enum Type { SJ_REGIONAL, TI_B_SJ }

final typeValues = new EnumValues({
  "SJ Regional": Type.SJ_REGIONAL,
  "TiB/SJ": Type.TI_B_SJ
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
