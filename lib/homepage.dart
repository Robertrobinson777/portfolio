import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:robby_portfolio/highlight.dart';
import 'package:url_launcher/url_launcher.dart';

import 'experience.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff28292E),
      backgroundColor: Colors.pink[900],

      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 56.0,
            groupAlignment: 1.0,
            // backgroundColor: Color(0xff2D3035),
            backgroundColor: Colors.pink[950],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/ogw/ADGmqu95rDpbsu281AnRdzv2joc-OySaL183HIFPDz92=s192-c-mo"),
                  ),
                ),
                // SizedBox(
                //   height: 108,
                // ),
                // RotatedBox(
                //   quarterTurns: -1,
                //   child: IconButton(
                //     icon: Icon(Icons.tune),
                //     color: Color(0xffFCCFA8),
                //     onPressed: () {},
                //   ),
                // )
              ],
            ),
            selectedLabelTextStyle: TextStyle(
              color: Colors.pink[900],
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
            unselectedLabelTextStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
            destinations: [
              buildRotatedTextRailDestination("Highlights", padding),
              buildRotatedTextRailDestination("Experience", padding),
              buildRotatedTextRailDestination("Education", padding),
              buildRotatedTextRailDestination("All", padding),
            ],
          ),
          // This is the main content.
          ContentSpace(_selectedIndex)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  final int _selectedIndex;

  ContentSpace(this._selectedIndex);

  final List<String> titles = [
    "Popular\nIdeas",
    "Favourites",
    "Inspiration\nIdeas",
    "All"
  ];

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var txthead = 60;
    var txthead1 = 60;
    switch (deviceType) {
      case DeviceScreenType.desktop:
        txthead = 60;
        txthead1 = 40;
        break;
      case DeviceScreenType.tablet:
        txthead = 30;
        txthead1 = 20;
        break;
      case DeviceScreenType.mobile:
        txthead = 30;
        txthead1 = 20;
        break;
      case DeviceScreenType.watch:
        txthead = 10;
        txthead1 = 07;
        break;
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildTitleName(txthead, 'Robert Robinson R'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.linkedin,
                        // size: 10,
                            color: Colors.white),
                        onPressed: () async {
                          var url =
                              'https://www.linkedin.com/in/robertrobinson777/';

                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                            // size: 10,
                              color: Colors.white),
                          onPressed: () => {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram,
                          // size: 10,
                              color: Colors.white),
                          onPressed: () => {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook,
                          // size: 10,
                              color: Colors.white),
                          onPressed: () => {})
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  buildTitleName(txthead1, 'Software Engineer'),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              _child(),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _child() {
    switch (_selectedIndex) {
      case 0:
        return Highlight();
        break;
      case 1:
        return Example9();
        break;
      // case 2:
      //   return Text(titles[_selectedIndex],
      //       style: Theme.of(context).textTheme.headline4);
      //   break;
      // // case 3:
      // //   return RequestListScreen();
      // //   break;
      // case 3:
      //   return Text(titles[_selectedIndex],
      //       style: Theme.of(context).textTheme.headline4);
      //   break;
    }
    return Container();
  }

  Widget buildTitleName(txthead, txt) {
    return Flexible(
      child: Text(
        txt,
        style: TextStyle(fontSize: txthead, color: Colors.white),
      ),
    );
  }
}
