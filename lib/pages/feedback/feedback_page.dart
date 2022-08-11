import 'package:flutter/material.dart' hide Feedback;
import 'package:get/get.dart';
import 'package:thebibleapp/components/z_button.dart';
import 'package:thebibleapp/components/z_text_form_field.dart';
import 'package:thebibleapp/models/feedback.dart';
import 'package:thebibleapp/models_services/firestore_service.dart';

import 'feedback_success_page.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  GlobalKey<ScaffoldState> globleKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  Feedback feedback = Feedback();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: globleKey, appBar: AppBar(title: Text('Feedback', style: TextStyle())), body: _bodyBuilder());
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
              feedback.name = value;
            },
            onSaved: (value) {
              feedback.name = value;
            },
          ),
          ZTextFormField(
            labelText: 'Email',
            onValueChanged: (value) {
              feedback.email = value;
            },
            onSaved: (value) {
              feedback.email = value;
            },
          ),
          ZTextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            labelText: 'Phone number',
            onValueChanged: (value) {
              feedback.phone = value;
            },
            onSaved: (value) {
              feedback.phone = value;
            },
          ),
          ZTextFormField(
            labelText: 'Message',
            maxLines: 4,
            onValueChanged: (value) {
              feedback.message = value;
            },
            onSaved: (value) {
              feedback.message = value;
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
      bool res = await FirestoreService.addFeedback(feedback);
      if (res) {
        Get.offAll(() => FeedbackSuccessPage());
      }
    }
  }
}
