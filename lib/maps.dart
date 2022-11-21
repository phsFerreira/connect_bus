// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:connect_bus/headerDrawer.dart';
import 'package:connect_bus/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-23.284715789779046, -47.675556474036625),
    zoom: 15.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Connect Bus"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [HeaderDrawer(), DrawerList()],
          )),
        ),
      ),
    );
  }

//MENU DRAWER
  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(),
        ],
      ),
    );
  }

  Widget menuItem() {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.home,
            size: 25,
            color: Colors.black,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 25,
            color: Colors.black,
          ),
          title: Text("Profile"),
          onTap: () {},
        ),
        SizedBox(height: 60),

        //emergencia button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration:
                BoxDecoration(color: Colors.white, border: Border.all()),
            child: Center(
              child: Text(
                "emergência",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),

        //ajuda button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration:
                BoxDecoration(color: Colors.white, border: Border.all()),
            child: Center(
              child: Text(
                "ajuda",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: 100),

        //sair button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: GestureDetector(
            onTap: () {
              //volta para a pagina inicial do app
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: Text(
                  "sair",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
