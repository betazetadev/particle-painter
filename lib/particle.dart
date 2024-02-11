import 'dart:ui';

class Particle {
  Offset position;
  Color color;
  double size;
  double dx; // Velocity in x direction
  double dy; // Velocity in y direction

  Particle({required this.position, required this.color, required this.size, required this.dx, required this.dy});
}