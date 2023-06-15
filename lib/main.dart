import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Lines(),
          ],
        ),
      ),
    ),
  ));
}

class Lines extends StatefulWidget {
  const Lines({Key? key}) : super(key: key);

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  List<Offset> points = [];
  bool isViewsConnected = false;

  void onViewsConnected() {
    setState(() {
      isViewsConnected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          points = [details.localPosition];
        });
      },
      onPanUpdate: (details) {
        setState(() {
          points = List.from(points)..add(details.localPosition);
        });
      },
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: LinesPainter(points, isViewsConnected),
          ),
          questions(),
          answer(),
        ],
      ),
    );
  }

  Widget questions() {
    return Container(
      margin: EdgeInsets.only(top: Get.width / 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  width: Get.width / 4,
                  height: Get.width / 8,
                  child: Text(
                    '12 + 8',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.width / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  width: Get.width / 4,
                  height: Get.width / 8,
                  child: Text(
                    '7 - 2',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget answer() {
    return Container(
      margin: EdgeInsets.only(top: Get.width / 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  width: Get.width / 4,
                  height: Get.width / 8,
                  child: Text(
                    '5',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.width / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  width: Get.width / 4,
                  height: Get.width / 8,
                  child: Text(
                    '20',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  final List<Offset> points;
  final bool isViewsConnected;

  LinesPainter(this.points, this.isViewsConnected);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.points != points || !isViewsConnected;
  }
}
