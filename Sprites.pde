
class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  PImage img;

  Particle(PVector l,PImage img_) {
    acc = new PVector(0,0);
    float vx = 0.3;
    float vy = 0.3 - 1.0;
    vel = new PVector(vx,vy);
    loc = l.get();
    lifespan = 1000.0;
    img = img_;
  }
  
  Particle(PVector l, PImage img_, float velX, float velY) {
    acc = new PVector(0, 0);
    float vx = velX;
    float vy = velY;
    vel = new PVector(vx, vy);
    loc = l.get();
    lifespan = random(500, 1000);
    img = img_;
  }

  void run() {
    update();
    render();
  }
  
  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 2.5;
    acc.mult(0); // clear Acceleration
  }

  // Method to display
  void render() {
    pushStyle();
    imageMode(CENTER);
    tint(255,map(lifespan, 0, 400, 255, 70));
    image(img,loc.x,loc.y);
    // Drawing a circle instead
    // fill(255,lifespan);
    // noStroke();
    // ellipse(loc.x,loc.y,img.width,img.height);
    popStyle();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Smoke Particle System

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed
  PImage img;

  ParticleSystem(int num, PVector v, PImage img_) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img));    // Add "num" amount of particles to the arraylist
    }
  }

  ParticleSystem(int num, PVector v, PImage img_, float vx, float vy) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img, vx, vy));    // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  // Method to add a force vector to all particles currently in the system
  void applyForce(PVector dir) {
    // Enhanced loop!!!
    for (Particle p: particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    if(particles.size() < 300)
    particles.add(new Particle(origin, img, random(-1, 1), random(-1, 1)));
  }
  
  int getParticleCount() {
    return particles.size();
  }
  
}

class Texto extends FBox {
  
  String texto;
  float textOffset;

  Texto(String _texto){
    super(textWidth(_texto), textAscent() + textDescent());
    texto = _texto;
    textOffset = textAscent() - getHeight()/2;
  }
  
  void draw(PGraphics applet) {
    super.draw(applet);

    preDraw(applet);
    fill(255);
    stroke(255);
    textAlign(CENTER);
    text(texto, 0, textOffset);
    postDraw(applet);
  }  
}

class Paddle extends FBox {
  PImage pI;
  Paddle(float x, float y, PImage im) {
    super(x, y);
    pI = im;
//    attachImage(im);
  }
  
  void draw(PGraphics applet) {
//    super.draw(applet);

//    preDraw(applet);
    imageMode(CENTER);
    image(pI, getX(), getY());
//    postDraw(applet);
  }

}

