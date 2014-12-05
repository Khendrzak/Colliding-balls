Bouncer[] bouncers = new Bouncer[250];
void setup() {
  size(displayWidth,displayHeight);
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i] = new Bouncer(random(15,40), random(5,10));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].colors();
    bouncers[i].display();
    bouncers[i].move();
    bouncers[i].bounce();
    for (int j = 0; j < bouncers.length; j++) {
      if (i!=j) {
        bouncers[i].collide(bouncers[j]);
      }
    }
  }
}

class Bouncer {
  PVector loc, vel;
  float sz;
  float speed;

  Bouncer(float tempsz, float tempspeed) {
    sz = tempsz;
    loc = new PVector(random(width-sz), random(height-sz));
    vel = PVector.random2D();
    speed = tempspeed;
    vel.mult(speed);
  }

  void colors(){
   fill(random(255),random(255),random(255)); 
  }
  
  void display() {
   triangle(loc.x, loc.y, loc.x-sz, loc.y+sz, loc.x+sz, loc.y+sz);
  }

  void move() {
    loc.add(vel);
  }

  void bounce() {
    if (loc.x + sz/2 > width || loc.x - sz/2 < 0) {
      vel.x *= -1;
    } 
    if (loc.y + sz/2 > height || loc.y - sz/2 < 0) {
      vel.y *= -1;
    }
  }

  void collide(Bouncer OtherBall) {
    if (loc.dist(OtherBall.loc) < sz/2 + OtherBall.sz/2) {
      vel = PVector.sub(loc, OtherBall.loc);
      vel.normalize();
      vel.setMag(speed);
    }
  }
}
