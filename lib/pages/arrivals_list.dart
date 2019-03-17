import 'package:flutter/material.dart';
import 'package:me305_final/services/station_services.dart';
import 'package:me305_final/model/response_arrivals.dart';
import 'package:me305_final/presentation/custom_icons_icons.dart' as CustomIcons;


class ArrivalsList extends StatelessWidget {
  final String id;

  ArrivalsList(this.id);

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(TransferA arrival) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading:  Column(
        children: <Widget>[
          Icon(CustomIcons.CustomIcons.train, color: Colors.white, size: 30.0),
          Text(arrival.train),
          //Text(arrival.type)
        ],
      ),

      title: Text(
        arrival.arrival,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: Text("From: ",
                    style: TextStyle(color: Colors.black)
                ),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(arrival.origin,
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
          Text(arrival.track),
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

    Card makeCard(TransferA arrival) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black26),
        child: makeListTile(arrival),
      ),
    );

    return FutureBuilder<List<TransferA>>(
        future: getArrivals(id),
        builder: (BuildContext context, AsyncSnapshot<List<TransferA>> snapshot) {
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
            return Center(
              child: CircularProgressIndicator(),
            );

          }
        }
    );

  }




}