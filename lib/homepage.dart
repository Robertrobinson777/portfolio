import 'package:flutter/material.dart';

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
            backgroundColor:Colors.pink[950],
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
                SizedBox(
                  height: 108,
                ),
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
              color: Color(0xffFCCFA8),
              fontSize: 13,
              letterSpacing: 0.8,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
            unselectedLabelTextStyle: TextStyle(
              fontSize: 13,
              letterSpacing: 0.8,
            ),
            destinations: [
              buildRotatedTextRailDestination("Popular", padding),
              buildRotatedTextRailDestination("Favourites", padding),
              buildRotatedTextRailDestination("Inspiration", padding),
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(titles[_selectedIndex],
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
