
class MenuScene {
  TheLameGame t;
  ParticleSystem ps;
  PImage pI = null, bootImg, star, new1, new2;
  Button newGame;
  Button credits;
  FBox chain1[] = new FBox[5];
  FCompound boot;
  int boxWidth = 100/(chain1.length) - 2;
  PFont pF;
  
  MenuScene(TheLameGame tl) {
    pF = loadFont("MetalMacabre-29.vlw");
    star = loadImage("LightPurpleBall.png");
    star.resize(2, 2);
    new1 = loadImage("resume1.png");
    new1.resize(80, 80);
    new2 = loadImage("resume2.png");
    new2.resize(80, 80);
    float vx = random(-1, 1);
    float vy = -vx;
    float r = random(0, 1);
    if(r > 0.49) {
      vy = -vx;
    }
    ps = new ParticleSystem(100, new PVector(width/2, height/2), star, vx, vy);
//    bootImg = loadImage("boot.png");
//    pI = loadImage("MenuBack.png");
//    pI.resize(width, height);
    newGame = new Button("New Game", (width - 300) / 2, (height - 100)/2 - 50, 300, 100);
//    newGame.setInactiveImage(new1);
//    newGame.setActiveImage(new2);
    credits = new Button("Credits", (width - 300) / 2, (height + 100)/2, 300, 100);
    t = tl;
    
  }
  
  void drawScene() {
    background(0, 0, 0);
    for (int i = 0; i < 2; i++) {
      ps.addParticle();
    }
    ps.run();
    pushStyle();
    newGame.display();
    credits.display();
    textFont(pF);
    textSize(40);
    text("TLG", width/2 - 150, 40);
    popStyle();
    
  }
  
  void mousePressed() {
    newGame.mousePressed();
  }
  
  void mouseMoved() {
    
  }
  
  void menuMouseReleased() {
    if(newGame.mouseReleased()) {
      t.initGame();
      TheLameGame.gameState = GAME_SCENE;
    }
    else if(credits.mouseReleased()) {
      t.initCredits();
      TheLameGame.gameState = CREDITS_SCENE;
    }
  }
  
}

