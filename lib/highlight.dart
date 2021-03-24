import 'package:flutter/material.dart';

class Highlight extends StatefulWidget {
  @override
  _HighlightState createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView(shrinkWrap: true, children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBodyText(
              'Customized CodeIgniter and made it run natively on Google Cloud App Engine Standard in 2016.'),
          buildBodyText(
              'Worked on the open source project yaapiyal and released under MIT license in GitHub.'),
          buildBodyText(
              'Can develop all layers of mobile applications using Flutter cross-platform framework.'),
          buildBodyText(
              'Expert in Google Cloud platform and have used various services.'),
          buildBodyText(
              'Google App Engine,Google Cloud Storage,Google Cloud SQL,Google Stackdriver,Gmail automation,Google Cloud Pub/Sub,Google BigQuery,Google Vision API.'),
          buildBodyText(
              'Worked on projects for companies in China, US, Middle East and India.'),
        ],
      )
    ]));
  }

  Widget buildBodyText(txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        txt,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
