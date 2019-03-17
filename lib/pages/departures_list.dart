import 'package:flutter/material.dart';
import 'package:me305_final/services/station_services.dart';
import 'package:me305_final/model/response_departures.dart';
import 'package:me305_final/presentation/custom_icons_icons.dart' as CustomIcons;


class DeparturesList extends StatelessWidget {
  final String id;

  DeparturesList(this.id);

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Transfer departure) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading:  Column(
        children: <Widget>[
          Icon(CustomIcons.CustomIcons.train, color: Colors.white, size: 30.0),
          Text(departure.train),
          //Text(departure.type)
        ],
      ),

      title: Text(
        departure.departure,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),


      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: Text("To: ",
                    style: TextStyle(color: Colors.black)
                ),
              )),
          Expanded(
            flex: 7,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(departure.destination,
                    style: TextStyle(color: Colors.black)
                  )
            ),
          )
        ],
      ),
      trailing:
      Column(
        children: <Widget>[
          Icon(CustomIcons.CustomIcons.track, color: Colors.white, size: 30.0),
          Text(departure.track),
        ],
      ),
    );

    Card makeCard(Transfer departure) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: makeListTile(departure),
      ),
    );

    return FutureBuilder<List<Transfer>>(
        future: getDepartures(id),
        builder: (BuildContext context, AsyncSnapshot<List<Transfer>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(snapshot.data[index]);

              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );

  }




}