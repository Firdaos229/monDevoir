import 'package:flutter/material.dart';
import 'package:text_recognition_flutter/TextScanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fond avec un dégradé doux
    final Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue, Colors.purple],
      ).createShader(
          Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)));

    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        backgroundPaint);

    // Cercle au centre avec une ombre douce
    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), 50.0, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: MyCustomPainter(),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextScanner()),
              );
            },
            child: const Text('Ouvrez la caméra !'),
          ),
        ),
      ),
    );
  }
}
