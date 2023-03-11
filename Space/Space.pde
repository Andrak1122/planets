float diff, xmag, ymag, newMWeel = 1, weelmause = 0, newXmag = 0, newYmag = 0;

int d = 200 * 5;

float[]
speed = {
    47.87,
    35.02,
    29.79,
    24.13,
    13.06,
    9.66,
    6.80,
    5.44,
    4.74,
    0
  },
  a = {
    0.387,
    0.723,
    1,
    1.52,
    5.2026,
    9.5549,
    19.218,
    30.11038,
    39.5181,
    0.01
  }, b,
  e = {
    0.2056,
    0.0067,
    0.0167,
    0.0934,
    0.0484,
    0.0555,
    0.0462,
    0.00898,
    0.2459,
    0
  },
  temp = {
    47.87,
    35.02,
    29.79,
    24.13,
    0,
    0,
    0,
    0,
    0,
    0
  },
  sizeofplanets = {
    2.440*2,
    6.052*2,
    6.378*2,
    3.397*2,
    71.490,
    60.270,
    25.560,
    24.760,
    1.151,
    20
  },
  angle = {
    0,
    177.36,
    23.45,
    25.19,
    3.13,
    25.33,
    97.86,
    28.31,
    122.52,
    50
  };

String[] names = {
  "Меркурий",
  "Венера",
  "Земля",
  "Марс",
  "Юпитер",
  "Сатурн",
  "Уран",
  "Нептун",
  "Плутон",
  "Солнце"
};

PImage[] im ;

void setup() {
  size(1920, 1000, P3D);
  
  frameRate(60);
  b = new float[10];
  im = new PImage[11];
  im[10] = loadImage("im/sky.jpg");
  sphereDetail(50);
  for (int i = 0; i <= 9; i = i + 1) {
    b[i] = a[i] * sqrt(1 - sq(e[i]));
    im[i] = loadImage("im/im"+str(i)+".jpg");
  }

  //im = loadImage("http://localhost:5000/uploads/im"+".jpg");
  //im = loadImage("sun.jpg");
    textureMode(NORMAL);

  
}

void mouseWheel(MouseEvent event) {
  weelmause += event.getCount();
  if (weelmause >= 8) {
    weelmause = 7;
  }
}
void planets() {
  for (int num = 0; num <= 9; num += 1) {
    if (keyPressed != true) {
      temp[num] = (temp[num] + speed[num] / (PI * d)) % TWO_PI;
    }
  }
}
void planetsdraw() {
  for (int num = 0; num <= 9; num += 1) {
    noFill();
    stroke(255, 255, 255,30);
    ellipse(0, 0, a[num] * 200, b[num] * 200);
    fill(255);

    translate(a[num] * sin(temp[num]) * 100, b[num] * cos(temp[num]) * 100, 0);
    rotateZ(PI);
    fill(255, 0, 0);
    if (weelmause > 6 && num > 3) {
      textSize(20 * weelmause);
      sizeofplanets[num] = sizeofplanets[num] * weelmause;
      text(names[num], sizeofplanets[num] + 10, sizeofplanets[num] + 10);
      sizeofplanets[num] = sizeofplanets[num] / weelmause;
      fill(255);
    } else {
      textSize(20);
      text(names[num], sizeofplanets[num] + 10, sizeofplanets[num] + 10);
      fill(255);
    }

    rotateZ(-PI);
    rotateX(PI / 2);
    rotateZ(PI * angle[num] / 360);
    
 //   beginShape();
   // texture(im);
    PShape sp = createShape(SPHERE, sizeofplanets[num]);
    sp.setStroke(false);
    sp.setTexture(im[num]);
    shape(sp);
    //sphere(sizeofplanets[num]);
//    endShape();
    
    rotateZ(-PI * angle[num] / 360);
    rotateX(-PI / 2);
    translate(-a[num] * sin(temp[num]) * 100, -b[num] * cos(temp[num]) * 100, 0);
  }
  float alfa = weelmause;
  if (alfa <= 0){ 
  alfa = 1;}
  PShape sp = createShape(SPHERE, 2000*alfa);
  sp.setStroke(false);
    sp.setTexture(im[10]);
    shape(sp);
}
void draw() {
  background(im[10]);
  planets();
  translate(width / 2, height / 2, -30);
  if (mousePressed && (mouseButton == LEFT)) {
    newXmag = mouseX / float(width) * TWO_PI;
    newYmag = mouseY / float(height) * TWO_PI;
    diff = xmag - newXmag;
    xmag -= diff / 4.0;
    diff = ymag - newYmag;
    ymag -= diff / 4.0;
  }
  scale(newMWeel - weelmause / 10);
  rotateX(-ymag);
  rotateY(-xmag);
  planetsdraw();
}
