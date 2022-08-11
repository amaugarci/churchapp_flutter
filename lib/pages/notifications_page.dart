import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/models/_parsers.dart';
import 'package:thebibleapp/models_providers/app_provider.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final notifications = appProvider.notifications;
    return Scaffold(
      appBar: AppBar(title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: [
          SizedBox(height: 8),
          for (var item in notifications)
            ZCard(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.timestampCreated != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(parseToDayTimeUTCString(item.timestampCreated)!, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
                        ],
                      ),
                    SizedBox(height: 8),
                    Text(item.title, style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text(item.body, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                  ],
                )),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
