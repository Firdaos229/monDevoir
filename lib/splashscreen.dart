import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_recognition_flutter/HomeScreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key});

  @override
  _MySplashState createState() => _MySplashState();
}

class CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 42, 50, 94); // Couleur du demi-cercle

    double radius = size.height / 10;

    // Demi-cercle supérieur gauche
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: radius),
      0,
      3.14,
      true,
      paint,
    );

    // Demi-cercle supérieur droit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, 0), radius: radius),
      -6,
      3.14,
      true,
      paint,
    );

    // Demi-cercle inférieur gauche
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height), radius: radius),
      0,
      -3.14,
      true,
      paint,
    );

    // Demi-cercle inférieur droit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, size.height), radius: radius),
      6,
      -3.14,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // You can adjust the duration as needed
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // CustomPainter for the semi-circles
          CustomPaint(
            painter: CustomBackgroundPainter(),
            child: Container(),
          ),
          // Apply the fade animation to your Column
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Text Recognition',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Image.asset('images/oc.png'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Traducteur de votre image en texte !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 73, 73, 73),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Get Started Button
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 215,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToHomePage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 50, 77, 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  child: Text(
                    'Commencez !',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 70, 58, 58),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
