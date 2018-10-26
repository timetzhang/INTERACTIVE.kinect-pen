class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  color fillColor;
  float radius = 12;
  float lifespan = 255;

  Particle(PVector l) {
    loc = l.get();
    acc = new PVector(random(-1.5, 1.5), random(-1.5, 1.5), 0);
    vel = new PVector(0, 0, 0);
    fillColor = color(random(255), random(255), random(255));
  }

  void update() {
    lifespan-=2;
    vel = new PVector(random(-2, 2), random(-2, 2), 0);
    vel.add(acc);
    loc.add(vel);
  }

  void display() {
    noStroke();
    rectMode(RADIUS);
    println(loc.z);
    for (int i=40; i>10; i--) {
      fill(fillColor, lifespan-i*5);
      ellipse(loc.x, loc.y, loc.z*2+(i-10), loc.z*2+(i-10));
    }

    //fill(fillColor, lifespan);
    //ellipse(loc.x, loc.y, radius, radius);
  }

  void checkEdge() {
    if (loc.y > height) {
      loc.y = 0;
      vel.y = -vel.y;
    }
    if (loc.x > width) {
      loc.x = 0;
      vel.x = -vel.x;
    }
    if (loc.y < 0) {
      loc.y = height;
      vel.y = -vel.y;
    }
    if (loc.x < 0) {
      loc.x = width;
      vel.x = -vel.x;
    }
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  void run() {
    update();
    checkEdge();
    display();
  }
}
