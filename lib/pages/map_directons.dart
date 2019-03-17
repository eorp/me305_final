import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapDirections extends StatefulWidget {

  @override
  MapDirectionsState createState() {
    return new MapDirectionsState();
  }
}

class MapDirectionsState extends State<MapDirections> {

  static const double lat = 2.813812,  long = 101.503413;
  static const String map_api= "API_KEY";

  @override
  Widget build(BuildContext context) {

    //method to launch maps
    void launchMap() async{
      const url = "https://www.google.com/maps/dir/?api=1&origin=59.607,16.5515&destination=59.60769488404283,16.55187132117313&travelmode=bicycling";
      if (await canLaunch(url)) {
        print("Can launch");
        void initState(){
          super.initState();

          canLaunch(url);
        }

        await launch(url);
      } else {
        print("Could not launch");
        throw 'Could not launch Maps';
      }
    }

    //method to bring out dialog
    void makeDialog(){
      showDialog(
          context: context,
          builder: (_) => new SimpleDialog(
            contentPadding: EdgeInsets.only(left: 30.0, top: 30.0),
            children: <Widget>[
              new Text("Address: ",
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

    return new Scaffold(
      body: new ListView.builder(
        itemBuilder: (context, index) => ExpansionTile(
          title: new Text("State ${index+1}"),
          children: <Widget>[
            new ListTile(
              title: new Text("Place 1"),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.info),
                      onPressed: makeDialog
                  ),
                  new IconButton(
                      icon: Icon(Icons.directions),
                      onPressed: launchMap
                  )
                ],
              ),
            ),
            new Divider(height: 10.0),
            new ListTile(
              title: new Text("Place 2"),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.info),
                      onPressed: makeDialog
                  ),
                  new IconButton(
                      icon: Icon(Icons.directions),
                      onPressed: launchMap
                  )
                ],
              ),
            )
          ],
        ),
        itemCount: 5,
      ),
    );
  }
}