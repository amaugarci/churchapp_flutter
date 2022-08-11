import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thebibleapp/components/z_button.dart';
import 'package:thebibleapp/components/z_text_form_field.dart';
import 'package:thebibleapp/models/prayer.dart';
import 'package:thebibleapp/models_services/firestore_service.dart';
import 'package:thebibleapp/pages/prayer/prayer_request_success_page.dart';

class PrayerRequestPage extends StatefulWidget {
  PrayerRequestPage({Key? key}) : super(key: key);

  @override
  _PrayerRequestPageState createState() => _PrayerRequestPageState();
}

class _PrayerRequestPageState extends State<PrayerRequestPage> {
  GlobalKey<ScaffoldState> globleKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  Prayer prayer = Prayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: globleKey, appBar: AppBar(title: Text('Prayer Request', style: TextStyle())), body: _bodyBuilder());
  }

  Widget _bodyBuilder() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 8),
          ZTextFormField(
            labelText: 'Name',
            onValueChanged: (value) {
              prayer.name = value;
            },
            onSaved: (value) {
              prayer.name = value;
            },
          ),
          ZTextFormField(
            labelText: 'Email',
            onValueChanged: (value) {
              prayer.email = value;
            },
            onSaved: (value) {
              prayer.email = value;
            },
          ),
          ZTextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            labelText: 'Phone number',
            onValueChanged: (value) {
              prayer.phone = value;
            },
            onSaved: (value) {
              prayer.phone = value;
            },
          ),
          ZTextFormField(
            labelText: 'How can we pray for you?',
            maxLines: 4,
            onValueChanged: (value) {
              prayer.message = value;
            },
            onSaved: (value) {
              prayer.message = value;
            },
          ),
          ZButton(
            text: 'Submit',
            onTap: () => _submit(),
          )
        ],
      ),
    );
  }

  void _submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      bool res = await FirestoreService.addPrayer(prayer);
      if (res) {
        Get.offAll(() => PrayerRequestSuccessPage());
      }
    }
  }
}
