import 'package:flutter/material.dart';
import 'package:me305_final/model/station_details.dart';
import 'package:me305_final/services/station_services.dart';
import 'package:me305_final/model/response_departures.dart';
import 'package:me305_final/model/response_arrivals.dart';
import 'package:me305_final/pages/placeholder_widget.dart';
import 'package:me305_final/pages/departures_list.dart';
import 'package:me305_final/pages/arrivals_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:me305_final/presentation/custom_icons_icons.dart' as CustomIcons;



class StationPage extends StatefulWidget {
  final StationDetails station;
  final String originLat;
  final String originLng;
  //final origin_lat
  StationPage({Key key, @required this.station, this.originLat, this.originLng}) : super(key: key);

  //final String title;

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  int _currentIndex = 0;
  Future<void> _launched;

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  //static String id = widget.station.id;

  //List<Transfer> departures;
  //List<TransferA> arrivals;



  @override
  Widget build(BuildContext context) {
    final String fromLat = widget.originLat;
    final String fromLng = widget.originLng;
    final String toLat = widget.station.lat.toString();
    final String toLng = widget.station.lng.toString();
    final String toLaunch = 'https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng';
    //method to launch maps
    void launchMap() async{
      const url = "https://www.google.com/maps/dir/?api=1&origin=59.6117677,16.5408913&destination=59.60769488404283,16.55187132117313";
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

final buildBottom = BottomNavigationBar(
  fixedColor: Colors.white,

  onTap: onTabTapped, // new
  currentIndex: _currentIndex, // new this will be set when a new tab is tapped
  items: [
    BottomNavigationBarItem(
      icon: new Icon(CustomIcons.CustomIcons.train_departure, size: 60.0,),
      title: new Text('Departures'),
    ),
    BottomNavigationBarItem(
      icon: new Icon(CustomIcons.CustomIcons.train_arrival, size: 60.0,),
      title: new Text('Arrivals'),
    ),

  ],

);

    final List<Widget> _children = [

      DeparturesList(widget.station.id),
      ArrivalsList(widget.station.id),

    ];

    final topAppBar = AppBar(
      elevation: 0.1,
         title: Text(widget.station.name),
         centerTitle: true,
         actions: <Widget>[
        IconButton(
          icon: Icon(Icons.directions),
          onPressed: () =>
              setState(() {
                _launched = _launchInWebViewWithJavaScript(toLaunch);
              }),//launchMap,//() {},
        )
      ],
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
          child: Text(
            //widget.station.name + "\n " +
                widget.station.address.toString().replaceAll("[", "").replaceAll("]", ""),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        preferredSize: Size(0.0, 80.0),
      ),
    );

    return Scaffold(
      //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: _children[_currentIndex], //buildBody,
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blue,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              //primaryColor: Colors.red,


              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.grey[350]))), // sets the inactive color of the `BottomNavigationBar`

          child: buildBottom
      ) ,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
