import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({ Key? key }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,     
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.black54),
          onPressed: () => Scaffold.of(context).openDrawer(),          
        ),
        leadingWidth: 20,
        title: const Text(
          "Map",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),        
        actions: [
          IconButton (
            onPressed: (){
              
            },
            icon: Icon(Icons.search, color: Colors.black54),
          ),
          IconButton (
            onPressed: (){  

            },
            icon: Icon(Icons.notifications_outlined, color: Colors.black54),
          ),          
        ],        
      ), 
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        // Show current location button
        SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: ClipOval(
                child: Material(
                  color: Colors.orange[100],
                  child: InkWell(
                    splashColor: Colors.orange, // inkwell color
                    child: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.my_location),
                    ),
                    onTap: () {
                      
                    },
                  ),
                ),
              )
            ),
          ),
        ),

        // Show zoom buttons
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.blue[100], // button color
                    child: InkWell(
                      splashColor: Colors.blue, // inkwell color
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.add),
                      ),
                      onTap: () {
                        
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipOval(
                  child: Material(
                    color: Colors.blue[100], // button color
                    child: InkWell(
                      splashColor: Colors.blue, // inkwell color
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.remove),
                      ),
                      onTap: () {
                        
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),  
      ]),
    );
  }
}