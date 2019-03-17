import 'package:flutter/material.dart';
import 'package:me305_final/services/station_services.dart';
import 'package:me305_final/model/response_departures.dart';
import 'package:me305_final/model/response_arrivals.dart';


class PlaceholderWidget extends StatelessWidget {
  //final Color color;
  //final List<dynamic> timetable;
  final String id;
  final int depart;

  PlaceholderWidget(this.id, this.depart);

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Transfer departure) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading:  Column(
        children: <Widget>[
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          Text(departure.train),
        ],
      ),
      /*Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),*/
      title: Text(
        departure.departure,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: Text("Going to: "),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(departure.destination,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Column(
        children: <Widget>[
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          Text(departure.track),
        ],
      ),

      onTap: () {
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(lesson: lesson)
            )
        );*/
      },
    );

    Card makeCard(Transfer departure) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black26),
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
                /*Media item = snapshot.data[index];
                        var media = Image.file(File(item.path));
                        return ListTile(
                          title: Text(item.timestamp),
                          leading: //new CircleAvatar(
                            //backgroundColor: Colors.blue,
                            //child: new Image(image: media),
                          //),
                        Text(item.id.toString()),
                          trailing: Text(item.notes),
                        );*/
              },
            );
          } else {
            return Center(child: Text("Empty"));
          }
        }
    );

  }




}