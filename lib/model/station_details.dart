class StationDetails{
  String _id;
  String _name;
  List<String> _address;
  double _lat;
  double _lng;
  int _distance;

  //StationDetails();


  StationDetails.withoutId(

   this._name,
   this._address,
   this._lat,
   this._lng
  );

  StationDetails(
      this._id,
      this._name,
      this._address,
      this._lat,
      this._lng,
      this._distance
      );


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'StationDetails{_id: $_id, _name: $_name, _address: $_address, _lat: $_lat, _lng: $_lng, _distance: $_distance}';
  }

  /*factory StationDetails.fromJson(Map<String, dynamic> parsedJson){
    return StationDetails(

      _name: parsedJson['_name'],
      address: parsedJson['location']['address']['formattedAddress'],
      lat: parsedJson['location']['address']['lat'],
      lng: parsedJson['location']['address']['lng'],
    );
  }*/



  String get name => _name;

  double get lng => _lng;

  set lng(double value) {
    _lng = value;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  List<String> get address => _address;

  set address(List<String> value) {
    _address = value;
  }

  set name(String value) {
    _name = value;
  }

  int get distance => _distance;

  set distance(int value) {
    _distance = value;
  }


}