class StationList{
  final List<Station> stations;
  StationList(
  {
    this.stations,
  });

  factory StationList.fromJson(List<dynamic> parsedJson){
    List<Station> stations = new List<Station>();
    stations = parsedJson.map((m)=>Station.fromJson(m)).toList();
    return new StationList(
      stations: stations
    );
  }
}


class Station{
  String id;
  String name;
  String code;
  String slug;
  String lat;
  String lng;

  Station({
    this.id,
    this.name,
    this.code,
    this.slug,
    this.lat,
    this.lng});

  factory Station.fromJson(Map<String, dynamic> parsedJson){
    return Station(
        id: parsedJson['id'],
        name: parsedJson['name'],
        code: parsedJson['code'],
        slug: parsedJson['slug'],
        lat: parsedJson['lat'],
        lng: parsedJson['lng']);
  }

  @override
  String toString() {
    return 'Station{id: $id, name: $name, code: $code, slug: $slug, lat: $lat, lng: $lng}';
  }

}