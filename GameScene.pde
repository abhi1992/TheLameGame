
class GameScene {
  float MIN_POW = 180, MAX_POW = 80;
  TheLameGame tlg;
  PImage im, pIm, pi, yel, pause1, pause2, bat1;
  Button pause;
  color bg;
  float x1, y1, velX = 2, power = 1, powerVel = 1, powerPos = 130;
  FCircle[] ar;
  FCircle c;
  Paddle b;
  boolean notPlaying = true;
  int score = 0, ball = 5;
  int pink = 8, yellow = 2;
  ParticleSystem ps;
  PImage star;
  
  GameScene(TheLameGame t) {
    
    star = loadImage("LightPurpleBall.png");
    star.resize(2, 2);
    float vx = random(-1, 1);
    float vy = -vx;
    float r = random(0, 1);
    if(r > 0.49) {
      vy = -vx;
    }
    ps = new ParticleSystem(100, new PVector(width/2, height/2), star, vx, vy);
    
    x1 = width/2;
    y1 = height - 40;
    im = loadImage("LightPurpleBall.png");
    bat1 = loadImage("Paddle.png");
    pIm = loadImage("GreenBall.png");
    pi = loadImage("LightPinkBall.png");
    yel = loadImage("YellowBall.png");
    pause1 = loadImage("pause1.png");
    pause2 = loadImage("pause2.png");
    pause1.resize(50, 50);
    pause2.resize(50, 50);
    bat1.resize(100, 20);
    im.resize(width/30, width/30);
    pIm.resize(width/30, width/30);
    pi.resize(width/30, width/30);
    yel.resize(width/30, width/30);
    tlg = t;
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    bg = color(int(random(0, 360)), 72, 40);
    popStyle();
    pause = new Button("", 10, 10, 50, 50);
    pause.setInactiveImage(pause1);
    pause.setActiveImage(pause2);
    
    world.clear();
    world = new FWorld();
    world.setEdges();
    world.remove(world.bottom);
    world.setGravity(0, 100);
    ar = new FCircle[100];
    imageMode(CENTER);
    for(int i = 0; i < 50; i+=2) {
      ar[i] = new FCircle(width/30);
      float x = i, y = random(30, height/2);
      if(i < 26) {
        x = map(x, 0, 25, 30, width/2-10);
        if(i > 4)
          y = random(30, height/2);
        else
          y = random(80, height/2);
        ar[i].attachImage(im);
        ar[i].setStatic(true);
        ar[i].setName("t");
        ar[i].setRestitution(1);
        ar[i].setGrabbable(false);
        ar[i].setPosition(x, y);
        world.add(ar[i]);
      }
      if(i >= 26) {
        x = map(x, 26, 50, 30, width/2-10);
        y = random(height/2 + 50, height - 50);
        ar[i].attachImage(im);
        ar[i].setStatic(true);
        ar[i].setName("t");
        ar[i].setRestitution(1);
        ar[i].setGrabbable(false);
        ar[i].setPosition(x, y);
        world.add(ar[i]);
      }
      
      ar[i + 1] = new FCircle(width/30);
      ar[i+1].setRestitution(1);
      ar[i+ 1].attachImage(im);
      ar[i+1].setName("t");
      ar[i+1].setGrabbable(false);
      ar[i+ 1].setStatic(true);
      ar[i+ 1].setPosition(width/2 + (width/2 -x), y);
      world.add(ar[i+1]);
      
    }
    
    for(int i = 0; i < 8; i++) {
      while(true) {
        int p = int(random(0, 49));
        if(ar[p].getName() == "t") {
          ar[p].attachImage(pi);
          ar[p].setName("pink");
          break;
        }
      }
    }
    
    for(int i = 0; i < 2; i++) {
      while(true) {  
        int p = int(random(0, 49));
        if(ar[p].getName() == "t") {
          ar[p].attachImage(yel);
          ar[p].setName("yel");
          break;
        }
      }
    }
    
    b = new Paddle(100, 20, bat1);
    y1 = height - 20;
//    b.setPosition(width/2 - 100 , y1);
    pushStyle();
//    imageMode(CENTER);
//    b.attachImage(bat1);
    popStyle();
    
    b.setStatic(true);
    b.attachImage(bat1);
    b.setGrabbable(false);
    
    b.setName("bat");
    world.add(b);
  }
  
  void createBall() {
    c = new FCircle(width/30);
    c.setPosition(width/2, 0);
    c.attachImage(pIm);
    c.setStatic(true);
    c.setRestitution(1);
    c.setRotatable(false);
    c.setVelocity(0, 200);
    c.setGrabbable(false);
    world.add(c);
    c.setName("Ball");
  }
  
  void drawScene() {
    drawBackground();
    update();
//    b.draw();
    world.step();
    world.draw();
    pause.display();
    drawPowerMeter();
    drawScore();
  }
  
  void drawPowerMeter() {
    if(notPlaying) {
      pushStyle();
      colorMode(RGB);
      fill(245, 119, 5, 180);
      rect(width - 40, MAX_POW, 20, MIN_POW - MAX_POW);
      fill(88, 7, 188, 180);
      rect(width - 40, MAX_POW, 20, powerPos - MAX_POW);
      popStyle();
    }
  }
  
  void drawScore() {
    
    text(""+score, width - textWidth(""+score) - 10, 40);
    text(""+ball, width - textWidth(""+ball) - 10, 70);
  }
  
  void updateScore(int s) {
    score+=s;
  }
  
  void updateBall(int b) {
    ball = b;
  }
  
  void update() {
    moveCollector();
    checkBall();
    checkGameOver();
    updatePowerMeter();
  }
  
  void updatePowerMeter() {
    
    if(powerPos < MAX_POW) {
      powerVel = -powerVel;
    }
    else if(powerPos > MIN_POW) {
      powerVel = -powerVel;
    }
    powerPos += powerVel;
    
  }
  
  void checkGameOver() {
    if(pink == 0 && notPlaying) {
      tlg.initGameComplete(score, pink, yellow);
      TheLameGame.gameState = GAME_COMPLETE_SCENE;
    }
    else if(ball == 0 && notPlaying) {
      tlg.initGameComplete(score, pink, yellow);
      TheLameGame.gameState = GAME_COMPLETE_SCENE;
    }
  }
  
  void checkBall() {
    if(!notPlaying && c.getY() > height) {
      notPlaying = true;
      world.remove(c);
    }
  }
  
  void contactStarted(FContact contact) { 
  
    if(contact.getBody1().getName() == "Ball" 
      && contact.getBody2().getName() == "t") {
      world.remove(contact.getBody2());
      updateScore(20);
    }
    else if(contact.getBody2().getName() == "Ball"
      && contact.getBody1().getName() == "t") {
      world.remove(contact.getBody1());
      updateScore(20);
    }
    else if(contact.getBody1().getName() == "Ball" 
      && contact.getBody2().getName() == "yel") {
      world.remove(contact.getBody2());
      updateScore(100);
      yellow--;
    }
    else if(contact.getBody2().getName() == "Ball"
      && contact.getBody1().getName() == "yel") {
      world.remove(contact.getBody1());
      updateScore(100);
      yellow--;
    }
    else if(contact.getBody1().getName() == "Ball" 
      && contact.getBody2().getName() == "pink") {
      world.remove(contact.getBody2());
      updateScore(50);
      pink--;
    }
    else if(contact.getBody2().getName() == "Ball"
      && contact.getBody1().getName() == "pink") {
      world.remove(contact.getBody1());
      updateScore(50);
      pink--;
    }
    else if(contact.getBody2().getName() == "Ball"
      && contact.getBody1().getName() == "bat") {
      world.remove(contact.getBody2());
      updateBall(ball+1);
      updateScore(50);
      notPlaying = true;
    }
    else if(contact.getBody1().getName() == "Ball" 
      && contact.getBody2().getName() == "bat") {
      world.remove(contact.getBody1());
      updateBall(ball+1);
      updateScore(50);
      notPlaying = true;
    }
  }
  
  void moveCollector() {
    x1 +=velX;
    if(x1 + 60 > width)
    velX = -velX;
    if(x1 < 60)
    velX = -velX;
    b.setPosition(x1, y1);
  }
  
  void drawBackground() {
    background(0, 0, 0);
    for (int i = 0; i < 2; i++) {
      ps.addParticle();
    }
    ps.run();
  }
  
  void gameMouseReleased() {
    if(pause.mouseReleased()) {
      TheLameGame.gameState = GAME_PAUSED_SCENE;
    }
    else if(notPlaying && ball > 0) {
      createBall();
      updateBall(ball - 1);
      c.setStatic(false);
      PVector v1 = new PVector(width/2, 0);
      PVector v2 = new PVector(mouseX, mouseY);
      v1.sub(v2);
      v1.mult(map(powerPos, MAX_POW, MIN_POW, -3, -1.9));
      v1.div(map(mouseY, 0, height, 1, 2));
      c.setVelocity(v1.x, v1.y);
      
      notPlaying = false;
    }
  }
  
  void mousePressed() {
     pause.mousePressed(); 
  }
}
