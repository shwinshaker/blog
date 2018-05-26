int xCount = 201;
int yCount = 201;
float gridSize;

boolean fDraw;
float wheelRoll;
float wheelStrength=20;
float IndRadius=100;
String indText;

boolean fMode;
float rectRadius=50;
float rectRound=10;
float mouseRm;
//PGraphics pg; 

color colorBg = #808A87;
color colorLine = #F0FFFF;
color colorInd = color(255, 0, 0);
color colorPanel = #FF9912;

GridPoints[] points = new GridPoints[xCount*yCount];
Attractor myAttractor;
Button resetButton;
Button modeButton;
TrigButton trigButton1;
TrigButton trigButton2;

void setup() {  
  // fullScreen();
  // colorMode(RGB, 255, 255, 255, 100);
  // smooth();
  size(400, 400);
  
  cursor(ARROW);
  mouseRm = min(width*0.01,height*0.01);

  ellipseMode(RADIUS);

  gridSize = max(width, height)*1.5;
  modeButton = new Button(width-rectRadius-5, rectRadius+5, rectRadius, "SQUARE");
  rectMode(RADIUS);
  resetButton = new Button(modeButton.Cx, modeButton.Cy + modeButton.Radius/2, modeButton.Radius/6, "CIRCLE");
  trigButton1 = new TrigButton(resetButton.Cx - modeButton.Radius/5*4, resetButton.Cy, 
                               resetButton.Cx - modeButton.Radius/5*4 + resetButton.Radius*2, resetButton.Cy + resetButton.Radius, 
                               resetButton.Cx - modeButton.Radius/5*4 + resetButton.Radius*2, resetButton.Cy - resetButton.Radius);
  trigButton2 = new TrigButton(resetButton.Cx + modeButton.Radius/5*4, resetButton.Cy, 
                               resetButton.Cx + modeButton.Radius/5*4 - resetButton.Radius*2, resetButton.Cy + resetButton.Radius, 
                               resetButton.Cx + modeButton.Radius/5*4 - resetButton.Radius*2, resetButton.Cy - resetButton.Radius);
   
  //pg = createGraphics(width, height);

  myAttractor = new Attractor(width/2, height/2, IndRadius, "ClockWise");
  indText = "ClockWise";
  initGrid();
  // drawLine();
  fDraw=false;
  fMode=true;
}

void keyPressed() {
  if (key == 'q' || key == 'B') {
    exit();
  }
}

void mouseMoved() {
  if (fMode && modeButton.inside(mouseX, mouseY)) {
    cursor(HAND);
  } else {
    cursor(CROSS);
  }
}

//void mouseWheel(MouseEvent event) {
//  wheelRoll = event.getCount();
//  IndRadius += wheelStrength*wheelRoll;
//}

//void keyPressed() {
//  if (key==CODED) {
//    if (keyCode==UP) {
//      IndRadius +=wheelStrength;
//    } else if (keyCode==DOWN) {
//      IndRadius -=wheelStrength;
//    }
//  }
//}

void mousePressed() {
  if (mouseButton==LEFT) {
    if (fMode && modeButton.inside(mouseX, mouseY)) {
      if (!(resetButton.inside(mouseX, mouseY)) && 
          !(trigButton1.inside(mouseX, mouseY)) && 
          !(trigButton2.inside(mouseX, mouseY))) {
        switch(myAttractor.attractMode) {
          case "ClockWise":
            myAttractor.attractMode = "Counter";
            break;
          case "Counter":
            myAttractor.attractMode = "Slash";
            break;
          case "Slash":
            myAttractor.attractMode = "BackSlash";
            break;
          case "BackSlash":
            myAttractor.attractMode = "ClockWise";
            break;
        }
        indText = myAttractor.attractMode;
      } else if (resetButton.inside(mouseX, mouseY)) {
        indText = "Reset";
        initGrid();
      } else if (trigButton1.inside(mouseX, mouseY)) {
        IndRadius -= wheelStrength;
      } else if (trigButton2.inside(mouseX, mouseY)) {
        IndRadius += wheelStrength;
      }
    } else {
      myAttractor.x = mouseX;
      myAttractor.y = mouseY;
      myAttractor.r = IndRadius;
      indText = myAttractor.attractMode;
      for (int i = 0; i < points.length; i++) {
        points[i].vel = new PVector(0, 0);
      }
      fDraw = true;
    }
  } else if (mouseButton==RIGHT) {
    if (fMode) {
      fMode = false;
    } else {
      fMode = true;
    }
    fDraw = false;
  }
}

void mouseReleased() {
  fDraw = false;
}

void draw() {
  if (fDraw) {
    attractUpdate();
    drawLine();
  } else {
    drawLine();
    if (!(mouseX<mouseRm) && !(mouseX>width-mouseRm) &&
        !(mouseY<mouseRm) && !(mouseY>width-mouseRm)){
      noFill();
      stroke(colorInd);
      strokeWeight(3);
      ellipse(mouseX, mouseY, IndRadius, IndRadius);
    }
    if (fMode) {
      fill(colorPanel);
      noStroke();
      rect(modeButton.Cx, modeButton.Cy, modeButton.Radius, modeButton.Radius, rectRound);

      fill(255);
      textSize(16);
      textAlign(CENTER, CENTER);
      text(indText, modeButton.Cx, modeButton.Cy-modeButton.Radius/3);

      fill(255);
      ellipse(resetButton.Cx, resetButton.Cy, resetButton.Radius, resetButton.Radius);
      triangle(trigButton1.ax, trigButton1.ay, trigButton1.bx, trigButton1.by, trigButton1.cx, trigButton1.cy);
      triangle(trigButton2.ax, trigButton2.ay, trigButton2.bx, trigButton2.by, trigButton2.cx, trigButton2.cy);
    }
  }
  saveFrame("frame/twist-####.png");
}

void initGrid() {
  int i = 0; 
  for (int y = 0; y < yCount; y++) {
    for (int x = 0; x < xCount; x++) {
      // from (w-g)/2 to (w+g)/2, grid and screen center superposed 
      float xPos = x*(gridSize/(xCount-1))+(width-gridSize)/2;
      float yPos = y*(gridSize/(yCount-1))+(height-gridSize)/2;
      points[i] = new GridPoints( new PVector(xPos, yPos) );
      i++;
    }
  }
}

// void drawLine() {
//   background(colorBg);
//   stroke(colorLine);
//   strokeWeight(3);
//   for (int i=0; i <points.length; i=i+xCount) {
//     for (int j=i; j<i+xCount-1; j++) {
//       line(points[j].loc.x, points[j].loc.y, points[j+1].loc.x, points[j+1].loc.y);
//     }
//   }
// }

void drawLine() {
  background(colorBg);
  stroke(colorLine);
  for (int i=0; i <points.length; i=i+xCount) {
    for (int j=i; j<i+xCount-1; j++) {
      point(points[j].loc.x, points[j].loc.y);
    }
  }
}

void attractUpdate() {
  for (int i = 0; i < points.length; i++) {
    myAttractor.attract(points[i]);
    points[i].update();
  }
}
