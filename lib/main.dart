import 'package:flutter/material.dart';
import 'particle_controller.dart';
import 'particle_painter.dart';

void main() {
  runApp(ParticleApp());
}

class ParticleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParticleScreen(),
    );
  }
}

class ParticleScreen extends StatefulWidget {
  @override
  _ParticleScreenState createState() => _ParticleScreenState();
}

class _ParticleScreenState extends State<ParticleScreen> {
  late ParticleController _controller;
  bool _isInitDone = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitDone) {
      _controller = ParticleController(
        numberOfParticles: 10, // Ajusta el número de partículas según sea necesario
        screenSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        onUpdated: () => setState(() {}),
      )..start();
      _isInitDone = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          _controller.addParticle(details.globalPosition);
        },
        child: CustomPaint(
          painter: ParticlePainter(particles: _controller.particles, time: DateTime.now().millisecondsSinceEpoch.toDouble()),
          child: Container(),
        ),
      ),
    );
  }
}
