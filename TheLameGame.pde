import fisica.*;
static final int MAIN_MENU_SCENE = 0;
static final int GAME_SCENE = 1;
static final int GAME_PAUSED_SCENE = 2;
static final int CREDITS_SCENE = 3;
static final int GAME_COMPLETE_SCENE = 4;

static int gameState;
PFont font;
GameScene g;
GamePausedScene gp;
MenuScene m;
static CreditsScene cr;
GameCompleteScene gc;
FWorld world;

void setup() {
  
  size(480, 600);
  gameState = MAIN_MENU_SCENE;
  Fisica.init(this);
  world = new FWorld();
  font = loadFont("AgencyFB-Reg-29.vlw");
  initMenu();
  gp = new GamePausedScene();
  frameRate(60);
  textFont(font);
  
}

void draw() {
  
  switch(gameState) {
    
    case MAIN_MENU_SCENE:
      m.drawScene();
      break;
    case GAME_SCENE:
      g.drawScene();
      break;
    case GAME_PAUSED_SCENE:
      gp.drawScene();
      break;
    case CREDITS_SCENE:
      cr.drawScene();
      break;
    case GAME_COMPLETE_SCENE:
      gc.drawScene();
      break;
  }
}

void mouseReleased() {
  
  switch(gameState) {
    
    case MAIN_MENU_SCENE:
      m.menuMouseReleased();
      break;
    
    case GAME_SCENE:
      g.gameMouseReleased();
      break;
    case GAME_PAUSED_SCENE:
      gp.gpMouseReleased();
      break;
    case CREDITS_SCENE:
      cr.crMouseReleased();
      break;
    case GAME_COMPLETE_SCENE:
      gc.gcMouseReleased();
      break;
  }
}

void mousePressed() {
  
  switch(gameState) {
    
    case MAIN_MENU_SCENE:
      m.mousePressed();
      break;
    
    case GAME_SCENE:
      g.mousePressed();
      break;
    case GAME_PAUSED_SCENE:
      gp.mousePressed();
      break;
    case CREDITS_SCENE:
      cr.mousePressed();
      break;
    case GAME_COMPLETE_SCENE:
      gc.mousePressed();
      break;
  }
}

void mouseMoved() {
  
//  switch(gameState) {
//    
//    case MAIN_MENU_SCENE:
//      m.mousePressed();
//      break;
//    
//    case GAME_SCENE:
//      g.mousePressed();
//      break;
//    case GAME_PAUSED_SCENE:
//      gp.mousePressed();
//      break;
//    case CREDITS_SCENE:
//      cr.mousePressed();
//      break;
//    case GAME_COMPLETE_SCENE:
//      gc.mousePressed();
//      break;
//  }
}

void initCredits() {
  cr = new CreditsScene();
}

void initMenu() {
    m = new MenuScene(this);
}

void contactStarted(FContact contact) { 
  
  switch(gameState) {
    
    case GAME_SCENE:
      g.contactStarted(contact);
      break;
  }
}

void initGame() {
  g = new GameScene(this);
}

void initGameComplete(int score, int pi, int ye) {
  gc = new GameCompleteScene(this, score, pi, ye);
}
