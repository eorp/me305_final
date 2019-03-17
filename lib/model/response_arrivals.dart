// To parse this JSON data, do
//
//     final responseArrivals = responseArrivalsFromJson(jsonString);

import 'dart:convert';

ResponseArrivals responseArrivalsFromJson(String str) {
  final jsonData = json.decode(str);
  return ResponseArrivals.fromJson(jsonData);
}

String responseArrivalsToJson(ResponseArrivals data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ResponseArrivals {
  StationA station;

  ResponseArrivals({
    this.station,
  });

  factory ResponseArrivals.fromJson(Map<String, dynamic> json) => new ResponseArrivals(
    station: StationA.fromJson(json["station"]),
  );

  Map<String, dynamic> toJson() => {
    "station": station.toJson(),
  };
}

class StationA {
  String id;
  String name;
  String code;
  String slug;
  String lat;
  String lng;
  Transfers transfers;

  StationA({
    this.id,
    this.name,
    this.code,
    this.slug,
    this.lat,
    this.lng,
    this.transfers,
  });

  factory StationA.fromJson(Map<String, dynamic> json) => new StationA(
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
  List<TransferA> transfer;

  Transfers({
    this.transfer,
  });

  factory Transfers.fromJson(Map<String, dynamic> json) => new Transfers(
    transfer: new List<TransferA>.from(json["transfer"].map((x) => TransferA.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transfer": new List<dynamic>.from(transfer.map((x) => x.toJson())),
  };
}

class TransferA {
  String id;
  String arrival;
  dynamic newArrival;
  String origin;
  String track;
  String train;
  String type;
  //Type type;
  String comment;
  String detected;
  String updated;

  TransferA({
    this.id,
    this.arrival,
    this.newArrival,
    this.origin,
    this.track,
    this.train,
    this.type,
    this.comment,
    this.detected,
    this.updated,
  });

  factory TransferA.fromJson(Map<String, dynamic> json) => new TransferA(
    id: json["id"],
    arrival: json["arrival"],
    newArrival: json["newArrival"],
    origin: json["origin"],
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
    "arrival": arrival,
    "newArrival": newArrival,
    "origin": origin,
    "track": track,
    "train": train,
    "type": type,//typeValues.reverse[type],
    "comment": comment == null ? null : comment,
    "detected": detected,
    "updated": updated == null ? null : updated,
  };

  @override
  String toString() {
    return 'TransferA{id: $id, arrival: $arrival, newArrival: $newArrival, origin: $origin, track: $track, train: $train, type: $type, comment: $comment, detected: $detected, updated: $updated}';
  }

}

enum Type { SJ_REGIONAL, KRSATGEN, TI_B_SJ, RESUNDSTG, BL_TGET }

final typeValues = new EnumValues({
  "Blå tåget": Type.BL_TGET,
  "Krösatågen": Type.KRSATGEN,
  "Öresundståg": Type.RESUNDSTG,
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
