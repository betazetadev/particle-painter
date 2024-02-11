import 'dart:math';
import 'package:flutter/material.dart';
import 'package:particle_painter/particle.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double time;
  final Random random = Random();

  ParticlePainter({required this.particles, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      var paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}