import 'package:flutter/material.dart';
import 'package:me305_final/model/station_details.dart';
import 'package:me305_final/pages/station_page.dart';

class StationsList extends StatefulWidget {
  final List<StationDetails> stations;
  final String lat;
  final String lng;

  StationsList({Key key, @required this.stations, this.lat, this.lng}): super(key: key);

  @override
  _StationsListState createState() => _StationsListState();
}

class _StationsListState extends State<StationsList> {
  @override
  Widget build(BuildContext context) {

    metersToKm(int meters){
      double distance;
      String m_km;
      String length = meters.toString();
      if(length.length > 3){
        distance = meters / 1000;
        m_km = "km";
      }
      else{
        distance = double.parse(length);
        m_km = "m";
      }

      return distance.toStringAsFixed(2) + " " + m_km;
    }
    ListTile makeListTile(StationDetails station) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Text(metersToKm(station.distance)),
        //Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text(
        station.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
       subtitle: Text(station.address.toString().replaceAll("[", "").replaceAll("]", ""),// + station.distance.toString(),
           style: TextStyle(color: Colors.white)),

      
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StationPage(station: station, originLat: widget.lat, originLng: widget.lng,)));
      },
    );

    Card makeCard(StationDetails station) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: makeListTile(station),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.stations.length,
          itemBuilder: (BuildContext context, int index){
              return makeCard(widget.stations[index]);
          },
      ),
    );
  }
}

