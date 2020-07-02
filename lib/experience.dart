import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    @required this.children,
    this.indicators,
    this.isLeftAligned = true,
    this.itemGap = 12.0,
    this.gutterSpacing = 4.0,
    this.padding = const EdgeInsets.all(8),
    this.controller,
    this.lineColor = Colors.white,
    this.physics,
    this.shrinkWrap = true,
    this.primary = false,
    this.reverse = false,
    this.indicatorSize = 60.0,
    this.lineGap = 4.0,
    this.indicatorColor = Colors.blue,
    this.indicatorStyle = PaintingStyle.fill,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 2.0,
    this.style = PaintingStyle.stroke,
  })  : itemCount = children.length,
        assert(itemGap >= 0),
        assert(lineGap >= 0),
        assert(indicators == null || children.length == indicators.length);

  final List<Widget> children;
  final double itemGap;
  final double gutterSpacing;
  final List<Widget> indicators;
  final bool isLeftAligned;
  final EdgeInsets padding;
  final ScrollController controller;
  final int itemCount;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final bool primary;
  final bool reverse;

  final Color lineColor;
  final double lineGap;
  final double indicatorSize;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      separatorBuilder: (_, __) => SizedBox(height: itemGap),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      controller: controller,
      reverse: reverse,
      primary: primary,
      itemBuilder: (context, index) {
        final child = children[index];

        Widget indicator;
        if (indicators != null) {
          indicator = indicators[index];
        }

        final isFirst = index == 0;
        final isLast = index == itemCount - 1;

        final timelineTile = <Widget>[
          CustomPaint(
            foregroundPainter: _TimelinePainter(
              hideDefaultIndicator: indicator != null,
              lineColor: lineColor,
              indicatorColor: indicatorColor,
              indicatorSize: indicatorSize,
              indicatorStyle: indicatorStyle,
              isFirst: isFirst,
              isLast: isLast,
              lineGap: lineGap,
              strokeCap: strokeCap,
              strokeWidth: strokeWidth,
              style: style,
              itemGap: itemGap,
            ),
            child: SizedBox(
              height: double.infinity,
              width: indicatorSize,
              child: indicator,
            ),
          ),
          SizedBox(width: gutterSpacing),
          Expanded(child: child),
        ];

        return IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                isLeftAligned ? timelineTile : timelineTile.reversed.toList(),
          ),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    @required this.hideDefaultIndicator,
    @required this.indicatorColor,
    @required this.indicatorStyle,
    @required this.indicatorSize,
    @required this.lineGap,
    @required this.strokeCap,
    @required this.strokeWidth,
    @required this.style,
    @required this.lineColor,
    @required this.isFirst,
    @required this.isLast,
    @required this.itemGap,
  })  : linePaint = Paint()
          ..color = lineColor
          ..strokeCap = strokeCap
          ..strokeWidth = strokeWidth
          ..style = style,
        circlePaint = Paint()
          ..color = indicatorColor
          ..style = indicatorStyle;

  final bool hideDefaultIndicator;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final double indicatorSize;
  final double lineGap;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;
  final Color lineColor;
  final Paint linePaint;
  final Paint circlePaint;
  final bool isFirst;
  final bool isLast;
  final double itemGap;

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorRadius = indicatorSize / 2;
    final halfItemGap = itemGap / 2;
    final indicatorMargin = indicatorRadius + lineGap;

    final top = size.topLeft(Offset(indicatorRadius, 0.0 - halfItemGap));
    final centerTop = size.centerLeft(
      Offset(indicatorRadius, -indicatorMargin),
    );

    final bottom = size.bottomLeft(Offset(indicatorRadius, 0.0 + halfItemGap));
    final centerBottom = size.centerLeft(
      Offset(indicatorRadius, indicatorMargin),
    );

    if (!isFirst) canvas.drawLine(top, centerTop, linePaint);
    if (!isLast) canvas.drawLine(centerBottom, bottom, linePaint);

    if (!hideDefaultIndicator) {
      final Offset offsetCenter = size.centerLeft(Offset(indicatorRadius, 0));

      canvas.drawCircle(offsetCenter, indicatorRadius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Example9 extends StatelessWidget {
  const Example9({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView(shrinkWrap: true, children: <Widget>[
      Timeline(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Software Engineer')],
          ),
          Container(height: 50, color: Colors.amber),
          Container(height: 200, color: Colors.amber),
          Container(height: 100, color: Colors.amber),
        ],
        indicators: <Widget>[
          Text('2017- Present'),
          // Icon(Icons.access_alarm),
          Icon(Icons.backup),
          Icon(Icons.accessibility_new),
          Icon(Icons.access_alarm),
        ],
      ),
    ]));
  }
}

// class TimelinePage extends StatefulWidget {
//   // TimelinePage({Key key, this.title}) : super(key: key);
//   // final String title;

//   @override
//   _TimelinePageState createState() => _TimelinePageState();
// }

// class _TimelinePageState extends State<TimelinePage> {
//   final PageController pageController =
//       PageController(initialPage: 1, keepPage: true);
//   int pageIx = 1;

//   @override
//   Widget build(BuildContext context) {
//     // List<Widget> pages = [
//     //   timelineModel(TimelinePosition.Left),
//     //   timelineModel(TimelinePosition.Center),
//     //   timelineModel(TimelinePosition.Right)
//     // ];

//     return Scaffold(
//         // bottomNavigationBar: BottomNavigationBar(
//         //     currentIndex: pageIx,
//         //     onTap: (i) => pageController.animateToPage(i,
//         //         duration: const Duration(milliseconds: 300),
//         //         curve: Curves.easeInOut),
//         //     items: const [
//         //       BottomNavigationBarItem(
//         //         icon: Icon(Icons.format_align_left),
//         //         title: Text("LEFT"),
//         //       ),
//         //       BottomNavigationBarItem(
//         //         icon: Icon(Icons.format_align_center),
//         //         title: Text("CENTER"),
//         //       ),
//         //       BottomNavigationBarItem(
//         //         icon: Icon(Icons.format_align_right),
//         //         title: Text("RIGHT"),
//         //       ),
//         //     ]),
//         appBar: AppBar(
//           title: Text('widget.title'),
//         ),
//         body: timelineModel()
//     );
//   }

//   timelineModel() => Timeline.builder(
//       itemBuilder: centerTimelineBuilder,
//       itemCount: doodles.length,
//       physics: BouncingScrollPhysics(),
//       position:  TimelinePosition.Center);

//   TimelineModel centerTimelineBuilder(BuildContext context, int i) {
//     final doodle = doodles[i];
//     final textTheme = Theme.of(context).textTheme;
//     return TimelineModel(
//         Card(
//           margin: EdgeInsets.symmetric(vertical: 16.0),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//           clipBehavior: Clip.antiAlias,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Image.network(doodle.doodle),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Text(doodle.time, style: textTheme.caption),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Text(
//                   doodle.name,
//                   style: TextStyle(fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         position:
//             i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
//         isFirst: i == 0,
//         isLast: i == doodles.length,
//         iconBackground: doodle.iconBackground,
//         icon: doodle.icon);
//   }
// }
