import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:particle_painter/particle.dart';

class ParticleController {
  List<Particle> particles = [];
  final int numberOfParticles;
  final Size screenSize;
  late Timer timer;
  final Function() onUpdated;
  Random random = Random();

  ParticleController({required this.numberOfParticles, required this.screenSize, required this.onUpdated}) {
    _initParticles();
  }

  void _initParticles() {
    for (int i = 0; i < numberOfParticles; i++) {
      var color = Colors.primaries[random.nextInt(Colors.primaries.length)];
      var size = random.nextDouble() * (screenSize.width / 50) + 2.0;
      var position = Offset(random.nextDouble() * screenSize.width, random.nextDouble() * screenSize.height);
      var dx = random.nextDouble() * 2 - 1; // Velocity in x direction
      var dy = random.nextDouble() * 2 - 1; // Velocity in y direction
      particles.add(Particle(position: position, color: color, size: size, dx: dx, dy: dy));
    }
  }

  void start() {
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      _updateParticles();
      onUpdated();
    });
  }

  void _updateParticles() {
    for (var particle in particles) {
      var newPosition = particle.position.translate(particle.dx, particle.dy);

      // Check for boundary collisions
      if (newPosition.dx <= 0 || newPosition.dx >= screenSize.width) {
        particle.dx = -particle.dx;
      }
      if (newPosition.dy <= 0 || newPosition.dy >= screenSize.height) {
        particle.dy = -particle.dy;
      }

      particle.position = particle.position.translate(particle.dx, particle.dy);
    }

    // Check for collisions between particles
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        var dx = particles[i].position.dx - particles[j].position.dx;
        var dy = particles[i].position.dy - particles[j].position.dy;
        var distance = sqrt(dx * dx + dy * dy);

        if (distance < particles[i].size + particles[j].size) {
          // The particles are colliding, swap their velocities
          var tempDx = particles[i].dx;
          var tempDy = particles[i].dy;
          particles[i].dx = particles[j].dx;
          particles[i].dy = particles[j].dy;
          particles[j].dx = tempDx;
          particles[j].dy = tempDy;
        }
      }
    }
  }

  void addParticle(Offset tapPosition) {
    var color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    var size = random.nextDouble() * (screenSize.width / 50) + 2.0;
    var dx = random.nextDouble() * 2 - 1; // Velocity in x direction
    var dy = random.nextDouble() * 2 - 1; // Velocity in y direction
    particles.add(Particle(position: tapPosition, color: color, size: size, dx: dx, dy: dy));
    onUpdated();
  }

  void stop() {
    timer.cancel();
  }
}
