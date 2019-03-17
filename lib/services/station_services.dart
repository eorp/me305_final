import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:me305_final/model/station.dart';
import 'package:me305_final/model/station_details.dart';
import 'package:http/http.dart' as http;
import 'package:me305_final/model/response_foursquare.dart';
import 'package:me305_final/model/response_departures.dart';
import 'package:me305_final/model/response_arrivals.dart';

var lat, lng;

/// Load json from assets
Future<String> _loadAStationAsset(String path) async {
  return await rootBundle.loadString(path);
}

StationDetails _getStationDetails(String json) {
  final responseFoursquare = responseFoursquareFromJson(json);
  List<Venue> venues = responseFoursquare.response.venues;
  List<StationDetails> foundStations = new List<StationDetails>();
  if(venues.length > 0) {

    venues.forEach((v) => foundStations.add(new StationDetails(null,v.name,v.location.formattedAddress,v.location.lat,v.location.lng)));

  }
  List<Station> stations;
  StationDetails test,station;
  loadStation().then((value){
    stations = value;
    for(var i = 0; i < stations.length; i++)
    {
      var name = stations[i].name;
      //print('found: $name');
      test = foundStations.firstWhere((s)=>s.name.startsWith(name),orElse: () => null);
      if(test != null)
      {
        test.id = stations[i].id;
        station = new StationDetails(test.id, test.name, test.address, test.lat, test.lng);
      }
    }
  });

  print(station.toString());
  return station;
}

/// Load Swedish train stations from json file
Future<List<Station>> loadStation() async {
  String jsonString = await _loadAStationAsset('assets/stations.json');
  final jsonResponse = json.decode(jsonString);
  StationList stationList = StationList.fromJson(jsonResponse['stations']['station']);
  List<Station> stations = stationList.stations;
  return stations;
}

///get details of nearby train stations
Future<StationDetails> getNearestFoursquareFromAssets() async{
  String jsonString = await _loadAStationAsset('assets/foursquareResponseVasteras.json');
  final responseFoursquare = responseFoursquareFromJson(jsonString);
  List<Venue> venues = responseFoursquare.response.venues;
  List<StationDetails> foundStations = new List<StationDetails>();
  if(venues.length > 0) {

    venues.forEach((v) => foundStations.add(new StationDetails(null,v.name,v.location.formattedAddress,v.location.lat,v.location.lng)));

  }
  List<Station> stations = await loadStation();
  StationDetails test,station;
  for(var i = 0; i < stations.length; i++)
  {
    var name = stations[i].name;
    //print('found: $name');
    test = foundStations.firstWhere((s)=>s.name.startsWith(name),orElse: () => null);
    if(test != null)
      {
        test.id = stations[i].id;
        station = new StationDetails(test.id, test.name, test.address, test.lat, test.lng);
      }
  }
  return station;
  //return _getStationDetails(jsonString);
}

Future<List<Transfer>> getDepartures(String id) async{
  var stationId = id;
  var url = 'https://us-central1-mytestproject-e7673.cloudfunctions.net/tagrider/v1/stations/$stationId/transfers/departures.json';
  var response = await http.get(url);
  List<Transfer> transfers;
  if(response.statusCode == 200){
    var responseDepartures = responseDeparturesFromJson(response.body);
    transfers = responseDepartures.station.transfers.transfer;
    //transfers.forEach((t)=>print(t.toString()));
  }

  return transfers;
}

Future<List<TransferA>> getArrivals(String id) async{
  var stationId = id;
  var url = 'https://us-central1-mytestproject-e7673.cloudfunctions.net/tagrider/v1/stations/$stationId/transfers/arrivals.json';
  var response = await http.get(url);
  List<TransferA> transfers;
  if(response.statusCode == 200){
    var responseDepartures = responseArrivalsFromJson(response.body);
    transfers = responseDepartures.station.transfers.transfer;
    //transfers.forEach((t)=>print(t.toString()));
  }

  return transfers;
}

Future<StationDetails> findNearestTrainStationFour(double lt, double lg) async{
  StationDetails station;
  // Foursquare client id
  var clientId = 'FZIQUGWI43WQ0XYPG43MXDJGNK4MDTTS3X1XDMSJVXDENHMV';
  // Foursquare client secret
  var clientSecret = '2FR5JJ0J1LECYH2OA40HSKGU4C515I4DGEDUBFC0BZLX4GEY';
  // Foursquare version date
  var version = '20190531';
  //var lat = 59.607;
  //var lng = 16.5515;
  var lat = lt;
  var lng = lg;
  var url = 'https://api.foursquare.com/v2/venues/search?ll=$lat,$lng&categoryId=4bf58dd8d48988d129951735&radius=5000'
      +'&client_id=$clientId&client_secret=$clientSecret&v=$version';
  var response = await http.get(url);
  if (response.statusCode == 200) {
    String responseBody = response.body;

    final responseFoursquare = responseFoursquareFromJson(responseBody);
    List<Venue> venues = responseFoursquare.response.venues;
    List<StationDetails> foundStations = new List<StationDetails>();
    if(venues.length > 0) {

      venues.forEach((v) => foundStations.add(new StationDetails(null,v.name,v.location.formattedAddress,v.location.lat,v.location.lng)));

    }
    List<Station> stations = await loadStation();
    StationDetails test;
    for(var i = 0; i < stations.length; i++)
    {
      var name = stations[i].name;
      //print('found: $name');
      test = foundStations.firstWhere((s)=>s.name.startsWith(name),orElse: () => null);
      if(test != null)
      {
        test.id = stations[i].id;
        station = new StationDetails(test.id, test.name, test.address, test.lat, test.lng);
      }
    }
    print(station.toString());
  } else {
    print('Something went wrong. \nResponse Code : ${response.statusCode}');
  }
  return station;
}

Future fetchJson() async {
  var response = await http.get(
    "https://us-central1-mytestproject-e7673.cloudfunctions.net/tagrider/v1/stations.json",
    //headers: {"Accept": "application/json"},
  );
  if (response.statusCode == 200) {
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    print(responseJSON['stations']['station']);

  } else {
    print('Something went wrong. \nResponse Code : ${response.statusCode}');
  }



}