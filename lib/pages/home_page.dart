import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:me305_final/services/station_services.dart';
import 'package:me305_final/pages/station_page.dart';
import 'package:me305_final/model/station_details.dart';
import 'package:me305_final/presentation/custom_icons_icons.dart' as CustomIcons;
import 'package:me305_final/pages/stations_list.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var location = new Location();

  Map<String, double> userLocation;

  Future<StationDetails> _station;

  StationDetails station;

  @override
  Widget build(BuildContext context) {

    void goToPage(StationDetails station, double lat, double lng) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationPage(station: station, originLat: lat.toString(), originLng: lng.toString()),
          )
      );
    }
    void goToListPage(List<StationDetails> stations, double lat, double lng) {
      Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (context) => StationPage(station: station, originLat: lat.toString(), originLng: lng.toString()),
            builder: (context) => StationsList(stations: stations, lat: lat.toString(), lng: lng.toString()),
          )
      );
    }
    //method to bring out dialog
    void makeDialog(){
      showDialog(
          context: context,
          builder: (_) => new SimpleDialog(
            contentPadding: EdgeInsets.only(left: 30.0, top: 30.0),
            children: <Widget>[
              new Text("No nearby train stations had been found. Perhaps you are not in Sweden. ",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              new ButtonBar(
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.close),
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  )
                ],
              )
            ],
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Swedstation"),
        centerTitle: true,
      ),
      body: //Center(
        //child:
        Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
               child: Text("If you are in Sweden, this application will help you to \n- locate the nearest trains station, "
                   "\n- display trains departures and arrivials and \n- get directions from your current location to that"
                   " train station",
                 style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
               ),
              ),
            ),

            //Text("test"),
            Expanded(
              flex: 4,
              child: Center(
                child: new LayoutBuilder(builder: (context, constraint) {
                  return new Icon(CustomIcons.CustomIcons.train_arrival, size: constraint.biggest.height);
            }),
              ),
            ),
            Expanded(
              flex:1,
              child: Center(
                child:
                (userLocation == null)
                    ? Text("")
                    : Text("Location:" +
                    userLocation["latitude"].toString() +
                    " " +
                    userLocation["longitude"].toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[



                  Padding(
                    padding: const EdgeInsets.all(10.0),

                    child: RaisedButton(
                      onPressed: () {
                        _getLocation().then((value) {
                          setState(() {
                            userLocation = value;
                          });
                          if(userLocation != null) {
                            _getStationDetailsList(
                                userLocation["latitude"], userLocation["longitude"])
                                .then((onValue) {
                              //print(onValue.toString());
                              (onValue != null) ?
                              //goToPage(onValue, userLocation["latitude"], userLocation["longitude"]) : makeDialog();
                              goToListPage(onValue, userLocation["latitude"], userLocation["longitude"]) : makeDialog();
                            });
                          }

                        });
                      },
                      color: Colors.blue,
                      child: Text("LOCATE NEAREST TRAIN STATION", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<StationDetails> _getStationDetails(double lat, double lng) async {
    StationDetails details;
    List<StationDetails> foundStations;
    try {
      //comment out this line
      //details = await getNearestFoursquareFromAssets();
      //uncomment this line
      //details = await findNearestTrainStationFour(lat, lng);
      //details
      foundStations = await findNearestTrainStationsFour(56.7007841, 16.1159646);
    } catch (e) {
      print(e.toString());
      details = null;
    }

    return details;
  }
  Future<List<StationDetails>> _getStationDetailsList(double lat, double lng) async {
    StationDetails details;
    List<StationDetails> foundStations;
    try {
      //comment out this line
      //details = await getNearestFoursquareFromAssets();
      //uncomment this line
      //details = await findNearestTrainStationFour(lat, lng);
      //details
      //foundStations = await findNearestTrainStationsFour(56.7007841, 16.1159646);
      foundStations = await findNearestTrainStationsFour(lat, lng);
    } catch (e) {
      print(e.toString());
      details = null;
    }

    return foundStations;
  }
}
