class CreditsScene {
  
  Button b;
  PImage img;
//  PFont f;
  FBody[] chain1 = new FBody[5];
  FBody[] chain2 = new FBody[5];
  float y = height/1.5, x = width/3;
  FCompound cage;
  int boxWidth = 100/(chain1.length) - 2;
  
  public CreditsScene() {
    world.clear();
    world.setGravity(0, 100);
    pushStyle();
    colorMode(HSB);
    world.setEdges(color(44, 15, 50));
    popStyle();
    
    for (int i = 0; i < chain1.length; i++) {
      chain1[i] = new FBox(boxWidth, 10);
      chain1[i].setPosition(x, map(i, 0, chain1.length-1, 10, boxWidth));
      chain1[i].setNoStroke();
      chain1[i].setFill(44, 55, 85);
      world.add(chain1[i]);
    }
    
    for (int i = 1; i < chain1.length; i++) {
      FDistanceJoint j = new FDistanceJoint(chain1[i-1], chain1[i]);
      j.setAnchor1(boxWidth/2, 0);
      j.setAnchor2(-boxWidth/2, 0);
      j.setLength(1);
      j.setFill(0);
      world.add(j);
    }
    
    for (int i = 0; i < chain2.length; i++) {
      chain2[i] = new FBox(boxWidth, 10);
      chain2[i].setPosition(x + width/3, map(i, 0, chain2.length-1, 10, boxWidth));
      chain2[i].setNoStroke();
      chain2[i].setFill(44, 55, 85);
      world.add(chain2[i]);
    }
    
    for (int i = 1; i < chain2.length; i++) {
      FDistanceJoint j = new FDistanceJoint(chain2[i-1], chain2[i]);
      j.setAnchor1(boxWidth/2, 0);
      j.setAnchor2(-boxWidth/2, 0);
      j.setLength(1);
      j.setFill(0);
      world.add(j);
    }
    
    FCircle p1 = new FCircle(10);
    p1.setStatic(true);
    p1.setPosition(width/3, -1);
    p1.setDrawable(false);
    world.add(p1);
    
    FCircle p2 = new FCircle(10);
    p2.setStatic(true);
    p2.setPosition(2*width/3, -1);
    p2.setDrawable(false);
    world.add(p2);
    
    cage = createCage();
    cage.setPosition(300, 100);
    cage.setDensity(0.01);
    cage.setBullet(true);
    world.add(cage);
    
    FDistanceJoint jP = new FDistanceJoint(chain1[0], cage);
    jP.setAnchor1(-boxWidth/2, 0);
    jP.setAnchor2(-150, -150);
    jP.setLength(1);
    jP.setFill(0);
    world.add(jP);
    
    jP = new FDistanceJoint(chain1[chain1.length - 1], p1);
    jP.setAnchor1(boxWidth/2, 0);
    jP.setAnchor2(0, 0);
    jP.setLength(1);
    jP.setFill(0);
    world.add(jP);
    
    jP = new FDistanceJoint(chain2[0], cage);
    jP.setAnchor1(-boxWidth/2, 0);
    jP.setAnchor2(150, -150);
    jP.setLength(1);
    jP.setFill(0);
    world.add(jP);
    
    jP = new FDistanceJoint(chain2[chain2.length - 1], p2);
    jP.setAnchor1(boxWidth/2, 0);
    jP.setAnchor2(0, 0);
    jP.setLength(1);
    jP.setFill(0);
    jP.setLength(0);
    
    world.add(jP);
    
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
    
    FRevoluteJoint axis = new FRevoluteJoint(cage, t);
    axis.setDrawable(false);
    axis.setCollideConnected(false);
    world.add(axis);
    
    t = new Texto("Banerjee");
    t.setPosition(320, 170);
    t.setFill(132, 241, 51, 200);
    t.setNoStroke();
    t.setGroupIndex(-1);
    t.setRestitution(1);
    world.add(t);
    
    b = new Button("Back", (width - 100) / 2, (height - 65), 100, 50);
    
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
    
    pushStyle();
    colorMode(HSB);
    FBox b = new FBox(300, 300);
    b.setFill(264, 81, 33);
    b.setNoStroke();
    b.setDensity(0.01);
    b.setGroupIndex(-1);
    popStyle();
    
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
  void mousePressed() {
  }
}
