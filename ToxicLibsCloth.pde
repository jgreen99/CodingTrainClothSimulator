import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;

int cols = 40;
int rows = 40;

ArrayList<Particle> particles;
ArrayList <Spring> springs;

float w = 10;

VerletPhysics2D physics;

void setup() {
  size(600, 400);

  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics2D();
  Vec2D gravity = new Vec2D(0, 10);
  GravityBehavior2D gb = new GravityBehavior2D(gravity);
  physics.addBehavior(gb);


  float x = 100;

  for (int j = 0; j < 40; j++) {
    float y = 10;



    for (int i = 0; i < particles.size()-1; i++) {
      Particle p = new Particle(x, y); 
      particles.add(p);
      physics.addParticle(p);
      y = y + w;
    }
    x = x + w;
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Particle a = particles.get(i);
      if (i != cols-1) {
        Particle b1 = particles.get(i+1);
        Spring s1 = new Spring(a, b1);
        springs.add(s1);
        physics.addSpring(s1);
      }
      if (j !=rows-1) {
        Particle b2 = particles[i][j+1];
        Spring s2 = new Spring(a, b2);
        springs.add(s2);
        physics.addSpring(s2);
      }
    }
  }

  Particle p1 = particles.get(0);
  p1.lock();
  Particle p2 = particles.get(particles.size()-1);
  p2.lock();
}

void draw() {
  background(51);
  physics.update();
  for (Particle p : particles) {
    p.display();
    for (Spring s : springs) {
      p.display();
    }
  }
}