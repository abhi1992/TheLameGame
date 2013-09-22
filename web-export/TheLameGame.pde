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
CreditsScene cr;
GameCompleteScene gc;
FWorld world;

void setup() {
  
  size(480, 600);
  gameState = MAIN_MENU_SCENE;
  Fisica.init(this);
  world = new FWorld();
  font = loadFont("Andalus-29.vlw");
  m = new MenuScene();
  g = new GameScene();
  gp = new GamePausedScene();
  cr = new CreditsScene();
  gc = new GameCompleteScene();
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
int HORIZONTAL = 0;
int VERTICAL   = 1;
int UPWARDS    = 2;
int DOWNWARDS  = 3;

class Widget
{

  
  PVector pos;
  PVector extents;
  String name;
  
  String getName()
  {
    return name;
  }
  
  void setName(String nm)
  {
    name = nm;
  }


  Widget(String t, int x, int y, int w, int h)
  {
    pos = new PVector(x, y);
    extents = new PVector (w, h);
    name = t;
    //registerMethod("mouseEvent", this);
  }

  void display()
  {
  }

  boolean isClicked()
  {
    
    if (mouseX > pos.x && mouseX < pos.x+extents.x 
      && mouseY > pos.y && mouseY < pos.y+extents.y)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public void mouseEvent(MouseEvent event)
  {
    //if (event.getFlavor() == MouseEvent.PRESS)
    //{
    //  mousePressed();
    //}
  }
  
  
  boolean mousePressed()
  {
    return isClicked();
  }
  
  boolean mouseDragged()
  {
    return isClicked();
  }
  
  
  boolean mouseReleased()
  {
    return isClicked();
  }
}

class Button extends Widget
{
  color imageTint = color(255);
  float scale = 1.0;
  
  Button(String nm, int x, int y, int w, int h)
  {
    super(nm, x, y, w, h);
  }

  void display()
  {
      pushStyle();
      stroke(255);
      noFill();
      rect(pos.x, pos.y, extents.x, extents.y);
      scale(scale);
      textAlign(CENTER, CENTER);
      text(name, pos.x + 0.5*extents.x, pos.y + 0.5* extents.y);
      popStyle();
  }
  
  boolean mousePressed()
  {
    if (super.mousePressed())
    {
      
      scale = 1.5;
      return true;
    }
    return false;
  }
  
  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      scale = 1; 
      return true;
    }
    return false;
  }
}

class MenuScene {

  PImage pI = null;
  Button newGame;
  Button credits;  
  
  MenuScene() {
    newGame = new Button("New Game", (width - 300) / 2, (height - 2*100 - 100 )/2, 300, 100);
    credits = new Button("Credits", (width - 300) / 2, (height )/2, 300, 100);
    
  }
  
  void drawScene() {
    background(206, 68, 44);
    
    newGame.display();
    credits.display();
    pushStyle();
    textSize(40);
    text("TLG", width/2 - 150, 40);
    popStyle();
  }
  
  void menuMouseReleased() {
    if(newGame.mouseReleased()) {
      TheLameGame.gameState = GAME_SCENE;
    }
    if(credits.mouseReleased()) {
      TheLameGame.gameState = CREDITS_SCENE;
    }
  }

}

static boolean gameComplete;
class GameScene {
  
  PImage img, pIm;
  Button pause;
  color bg;
  
  GameScene() {
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    bg = color(int(random(0, 360)), 72, 40);
    popStyle();
    pause = new Button("||", 10, 10, 40, 40);
  }
  
  void drawScene() {
    drawBackground();
    pause.display();
  }
  
  void drawBackground() {
    background(bg);
  }
 
   void gameMouseReleased() {
    
    if(pause.mouseReleased()) {
      TheLameGame.gameState = GAME_PAUSED_SCENE;
    }
  }
  
}


class GamePausedScene {
  
  Button menu, resume;
  
  GamePausedScene() {
    menu = new Button("Menu", (width - 300)/2 + 25, (height) / 2, 100, 40);
    resume = new Button("Resume", (width - 300)/2 + 300 - 25 - 120, (height) / 2, 120, 40);
  }
  
  void drawScene() {
    pushStyle();
    strokeWeight(4);
    stroke(0, 0, 0);
    strokeJoin(ROUND);
    fill(44, 88, 206);
    rect((width - 300)/2, (height - 300) / 2, 300, 300);
    popStyle();
    text("Paused", (width - 300) / 2 + 100, (height - 300) / 2 + 50);
    menu.display();
    resume.display();
  }
  
  void gpMouseReleased() {
    if(menu.mouseReleased()) {
      TheLameGame.gameState = MAIN_MENU_SCENE;
    }
    if(resume.mouseReleased()) {
      TheLameGame.gameState = GAME_SCENE;
    }
  }
  
}

class CreditsScene {
  
  Button b;
  FBody[] steps = new FBody[10];
  float frequency = 5, damping = 100, y = height/1.5;
  FCompound cage;
  int boxWidth = 400/(steps.length) - 2;
  
  CreditsScene() {
    world.clear();
    world.setGravity(0, 100);
    for (int i = 0; i < steps.length; i++) {
      steps[i] = new FBox(boxWidth, 10);
      steps[i].setPosition(map(i, 0, steps.length-1, boxWidth, width-boxWidth), y);
      steps[i].setNoStroke();
      steps[i].setFill(44, 55, 85);
      world.add(steps[i]);
    }
    
    for (int i = 1; i < steps.length; i++) {
      FDistanceJoint j = new FDistanceJoint(steps[i-1], steps[i]);
      j.setAnchor1(boxWidth/2, 0);
      j.setAnchor2(-boxWidth/2, 0);
      j.setFrequency(frequency);
      j.setDamping(damping);
      j.setFill(0);
      j.calculateLength();
      world.add(j);
    }
    
    FCircle left = new FCircle(10);
    left.setStatic(true);
    left.setPosition(0, y);
    left.setDrawable(false);
    world.add(left);
  
    FCircle right = new FCircle(10);
    right.setStatic(true);
    right.setPosition(width, y);
    right.setDrawable(false);
    world.add(right);
  
    FDistanceJoint jP = new FDistanceJoint(steps[0], left);
    jP.setAnchor1(-boxWidth/2, 0);
    jP.setAnchor2(0, 0);
    jP.setFrequency(frequency);
    jP.setDamping(damping);
    jP.calculateLength();
    jP.setFill(0);
    world.add(jP);
  
    FDistanceJoint jF = new FDistanceJoint(steps[steps.length-1], right);
    jF.setAnchor1(boxWidth/2, 0);
    jF.setAnchor2(0, 0);
    jF.setFrequency(frequency);
    jF.setDamping(damping);
    jF.calculateLength();
    jF.setFill(0);
    world.add(jF);
    
    cage = createCage();
    cage.setPosition(300, 100);
    cage.setRotation(PI/6);
    cage.setDensity(0.01);
    cage.setBullet(true);
    world.add(cage);
    
     
    
    textFont(font, 29);
    Texto t = new Texto("Created By : ");
    t.setPosition(320, 110);
    t.setRotation(random(-1, 1));
    t.setFill(96, 26, 19, 200);
    t.setNoStroke();
    t.setRestitution(0.75);
    t.setGroupIndex(-1);
    world.add(t);
    
    t = new Texto("Abhishek");
    t.setPosition(320, 140);
    t.setRotation(random(-1, 1));
    t.setFill(252, 133, 36, 200);
    t.setNoStroke();
    t.setRestitution(0.75);
    t.setGroupIndex(-1);
    world.add(t);
    
    t = new Texto("Banerjee");
    t.setPosition(320, 170);
    t.setRotation(random(-1, 1));
    t.setFill(132, 241, 51, 200);
    t.setNoStroke();
    t.setGroupIndex(-1);
    t.setRestitution(0.75);
    world.add(t);
    
    b = new Button("Back", (width - 100) / 2, (height - 300) / 2 + 300 - 60, 100, 50);
    
  }
  
  FCompound createCage() {
    FBox b1 = new FBox(10, 310);
    b1.setPosition(150, 0);
    b1.setFill(0);
    b1.setNoStroke();
  
    FBox b2 = new FBox(10, 310);
    b2.setPosition(-150, 0);
    b2.setFill(0);
    b2.setNoStroke();
    
    FBox b3 = new FBox(310, 10);
    b3.setPosition(0, 150);
    b3.setFill(0);
    b3.setNoStroke();
    
    FBox b4 = new FBox(310, 10);
    b4.setPosition(0, -150);
    b4.setFill(0);
    b4.setNoStroke();
    
    FBox b = new FBox(300, 300);
//    b.setPosition(0, -150);
    b.setFill(132);
    b.setNoStroke();
    b.setGroupIndex(-1);
    
    FCompound result = new FCompound();
    result.addBody(b1);
    result.addBody(b2);
    result.addBody(b3);
    result.addBody(b4);
    result.addBody(b);
    return result;
  }
  
  void drawScene() {
    
    background(44, 15, 85);
    b.display();
    world.step();
    world.draw();
  }
  
  void crMouseReleased() {
  
    if(b.mouseReleased()) {
      TheLameGame.gameState = MAIN_MENU_SCENE;
    }
  
  }

}

class GameCompleteScene {
  
  Button b;
  
  GameCompleteScene() {
    
    b = new Button("Back", (width - 100) / 2, (height- 50) , 100, 50);
    
  }
  
  void drawScene() {
    
    pushStyle();
    strokeWeight(4);
    stroke(0, 0, 0);
    strokeJoin(ROUND);
    fill(44, 88, 206);
    
    rect((width - 300)/2, (height - 300) / 2, 300, 300);
    popStyle();
    text("", (width - 300)/2 + 30, (height - 300) / 2 + 60);
    b.display();
  }
  
  void gcMouseReleased() {
  
    if(b.mouseReleased()) {
      gameComplete = true;
      TheLameGame.gameState = GAME_SCENE;
    }
  
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


