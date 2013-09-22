
class GamePausedScene {
  
  Button menu, resume;
  PImage back, menu1, menu2, resume1, resume2;
  
  GamePausedScene() {
    back = loadImage("L.png");
    back.resize(300, 300);
    
    menu1 = loadImage("menu1.png");
    menu1.resize(80, 80);
    menu2 = loadImage("menu2.png");
    menu2.resize(80, 80);
    resume1 = loadImage("resume1.png");
    resume1.resize(80, 80);
    resume2 = loadImage("resume2.png");
    resume2.resize(80, 80);
    
    menu = new Button("", (width - 300)/2 + 50, (height) / 2, 80, 80);
    resume = new Button("", (width - 300)/2 + 300 -50 - 80, (height) / 2, 80, 80);
    menu.setInactiveImage(menu1);
    menu.setActiveImage(menu2);
    resume.setInactiveImage(resume1);
    resume.setActiveImage(resume2);
  }
  
  void drawScene() {
    pushStyle();
    imageMode(CORNER);
    image(back, (width - 300)/2, (height - 300) / 2);
    popStyle();
    text("Paused", (width - 300) / 2 + (300 - textWidth("Paused"))/2, (height - 300) / 2 + 50);
    menu.display();
    resume.display();
  }
  
  void gpMouseReleased() {
    if(menu.mouseReleased()) {
      initMenu();
      TheLameGame.gameState = MAIN_MENU_SCENE;
    }
    if(resume.mouseReleased()) {
      TheLameGame.gameState = GAME_SCENE;
    }
  }
  
  void mousePressed() {
    menu.mousePressed();
    resume.mousePressed();
  }
  
}

class GameCompleteScene {
  TheLameGame t;
  PImage back, menu1, menu2, next1, next2, star1, star2, icon;
  Button b, m;
  float angle = 0, v = 0;
  int score;
  PFont f;
  int pink, yellow;
  
  GameCompleteScene(TheLameGame tl, int sc, int p, int y) {
    f = loadFont("MetalMacabre-29.vlw");
    back = loadImage("L.png");
    back.resize(350, 350);
    menu1 = loadImage("menu1.png");
    menu1.resize(80, 80);
    menu2 = loadImage("menu2.png");
    menu2.resize(80, 80);
    next1 = loadImage("next1.png");
    next1.resize(80, 80);
    next2 = loadImage("next2.png");
    next2.resize(80, 80);
    star1 = loadImage("Star1.png");
    star1.resize(64, 64);
    star2 = loadImage("Star2.png");
    star2.resize(64, 64);
    b = new Button("", (width - 300) / 2 + 200,  (height - 300) / 2 + 200, 80, 80);
    m = new Button("", (width - 300) / 2 + 20, (height - 300) / 2 + 200, 80, 80);
    m.setInactiveImage(menu1);
    m.setActiveImage(menu2);
    b.setInactiveImage(next1);
    b.setActiveImage(next2);
    
    t = tl;
    score = sc;
    pink = p;
    yellow = y;
    if(pink > 0) {
      icon = loadImage("LooseIcon.png");
    }
    else {
      icon = loadImage("WinIcon.png");
    }
    icon.resize(64, 64);
  }
  
  void drawScene() {
    
    pushStyle();
    imageMode(CORNER);
    image(back, (width - 350)/2, (height - 350) / 2);
    fill(255);
    pushMatrix();
    imageMode(CENTER);
    angle = map(noise(v), 0, 1, -PI/4, PI/4);
    translate((width-350)/2 + 64, (height-350)/2 + 64);
    rotate(angle);
    image(icon, 0, 0);
    v+=0.01;
    popMatrix();
    fill(0);
    textFont(f);
    textSize(20);
    text("Your Score : " + score, (width-300)/2+50, (height - 300) / 2 + 80);
    popStyle();
    drawStar();
    b.display();
    m.display();
  }
  
  void drawStar() {
    
    image(star2, (width-300)/2+79, (height - 300) / 2 + 150);
    image(star2, (width-300)/2+143, (height - 300) / 2 + 150);
    image(star2, (width-300)/2+207, (height - 300) / 2 + 150);
    
    if(pink <= 0 && yellow == 0) {
      image(star1, (width-300)/2+207, (height - 300) / 2 + 150);
    }
    if(pink <= 0 && yellow <= 1) {
      image(star1, (width-300)/2+143, (height - 300) / 2 + 150);
    }
    if(pink <= 0) {
      image(star1, (width-300)/2+79, (height - 300) / 2 + 150);
    }
    
    
  }
  
  void gcMouseReleased() {
  
    if(b.mouseReleased()) {
      t.initGame();
      TheLameGame.gameState = GAME_SCENE;
    }
    if(m.mouseReleased()) {
      t.initMenu();
      TheLameGame.gameState = MAIN_MENU_SCENE;
    }
  }
  
  void mousePressed() {
    b.mousePressed();
    m.mousePressed();
  }
}
