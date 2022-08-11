import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/components/z_image_display.dart';
import 'package:thebibleapp/models/_parsers.dart';
import 'package:thebibleapp/models_providers/app_provider.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final events = appProvider.events;
    return Scaffold(
      appBar: AppBar(title: Text('Events', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: [
          for (var item in events)
            ZCard(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZImageDisplay(imageUrl: item.imageUrl, height: 200, width: double.infinity, borderRadius: BorderRadius.circular(4)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(item.name, style: TextStyle(fontWeight: FontWeight.w600)),
                        Spacer(),
                        if (item.timestampCreated != null)
                          Text(parseToDayTimeUTCString(item.timestampCreated)!, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(item.location, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                    SizedBox(height: 8),
                    Text(item.description, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                  ],
                )),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
