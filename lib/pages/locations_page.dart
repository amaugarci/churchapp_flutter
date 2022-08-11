import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/models_providers/app_provider.dart';

class LocationsPage extends StatefulWidget {
  LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final locations = appProvider.locations;
    return Scaffold(
      appBar: AppBar(title: Text('Locations', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: [
          SizedBox(height: 8),
          for (var item in locations)
            ZCard(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(item.name, style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text(item.pastor, style: TextStyle()),
                    SizedBox(height: 12),
                    buildItem(icon: Icons.phone, label: item.phone),
                    buildItem(icon: Icons.email, label: item.email),
                    buildItem(icon: Icons.gps_fixed, label: item.address),
                  ],
                )),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  buildItem({required IconData icon, required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ZCard(
            child: Icon(icon, size: 16),
            borderRadius: BorderRadius.circular(50),
            margin: EdgeInsets.zero,
            color: Colors.cyan.shade100,
            padding: EdgeInsets.all(4),
          ),
          SizedBox(width: 8),
          Text(label)
        ],
      ),
    );
  }
}
