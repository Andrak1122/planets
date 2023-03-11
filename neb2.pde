float xmag, ymag , newMWeel = 1, weelmause = 0;
float newXmag, newYmag = 0; 


int d = 200*10 ;
float[]
speed ,
a,
b ,
e ,
temp = {47.87,35.02,29.79,24.13,0,0,0,0,0,0};


void setup()
{
  speed = new float[10];
  a = new float[10];
  b = new float[10];
  e = new float[10];
  size(1500, 1000, P3D);
  fill(255);

  frameRate(60);
  speed[0] =   47.87;speed[1] =   35.02;speed[2] = 29.79;speed[3] =   24.13;speed[4] = 13.06;speed[5] =   9.66;speed[6] =   6.80;speed[7] =   5.44;speed[8] = 4.74;speed[9] = 0;
  e[0] = 0.2056;e[1] = 0.0067;e[2] = 0.0167;e[3] = 0.0934;e[4] = 0.0484;e[5] = 0.0555;e[6] = 0.0462;e[7] = 0.00898;e[8] = 0.2459;e[9] = 0;
  a[0] = 0.387;a[1] = 0.723;a[2] = 1;a[3] = 1.52;a[4] = 5.2026;a[5] = 9.5549;a[6] = 19.218;a[7] = 30.11038;a[8] = 39.5181;a[9] = 0;
  
  for (int i = 0; i < 9; i = i+1) {
  b[i] = a[i]*sqrt(1-sq(e[i]));
  } 
  b[1] = a[1]*sqrt(1-sq(e[1]));
println(a[1],b[1]);
}


void planets(int num)
{
    noFill();
  ellipse(0,0,a[num]*200,b[num]*200);
  fill(255);
    temp[num] = (temp[num]+ speed[num]/(PI*d))%TWO_PI ;
  translate(a[num]*sin(temp[num])*100, b[num]*cos(temp[num])*100, 0);
  text("Привет я планета",10,10);
    rotateZ(PI/3.0);
    sphereDetail(7);
  sphere(6);
  rotateZ(-PI/3.0);
  translate(-a[num]*sin(temp[num])*100, -b[num]*cos(temp[num])*100, 0);  
}

void mouseWheel(MouseEvent event) {
      weelmause += event.getCount();
   
  }

void draw()  { 
  background(150);
//  sphere(40);
  
//  pushMatrix(); 
  translate(width/2, height/2, -30); 
  
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;

    
  float diff = xmag-newXmag;
//  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
//  }
  
  diff = ymag-newYmag;
//  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
//  }
  
//  diff = weelmause - newMWeel;
//   weelmause -= diff; 
   
  scale(newMWeel - weelmause/10);
  
  rotateX(-ymag); 
  rotateY(-xmag); 
  

  fill(255);
  translate(0, 0, 0);
    sphereDetail(20);
  sphere(20);
  
  planets(0);
  planets(1);
    planets(2);
  planets(3);
  planets(4);
  planets(5);
    planets(6);
  planets(7);
    planets(8);
/*  
  noFill();
  ellipse(0,0,a[1]*200,b[1]*200);
  fill(255);
    temp[1] = (temp[1]+ speed[1]/(PI*d))%TWO_PI ;
  translate(a[1]*sin(temp[1])*100, b[1]*cos(temp[1])*100, 0);
    sphereDetail(5);
  sphere(4);
  translate(-a[1]*sin(temp[1])*100, -b[1]*cos(temp[1])*100, 0);  

  noFill();
  ellipse(0,0,a[2]*200,b[2]*200);
  fill(255);
  temp[2] = (temp[2]+ speed[2]/(PI*d))%TWO_PI ;
  translate(a[2]*sin(temp[2])*100, b[2]*cos(temp[2])*100, 0);
    sphereDetail(5);
  sphere(4);
  translate(-a[2]*sin(temp[2])*100, -b[2]*cos(temp[2])*100, 0);
 */ 
/*    noFill();
  ellipse(0,0,a[3]*200,b[3]*200);
  fill(255);
  translate(a[3]*sin(temp)*100, b[3]*cos(temp)*100, 0);
    sphereDetail(5);
  sphere(4);
  translate(-a[3]*sin(temp)*100, -b[3]*cos(temp)*100, 0);
  
    
    noFill();
  ellipse(0,0,a[0]*200,b[0]*200);
  fill(255);
  translate(a[0]*sin(temp)*100, b[0]*cos(temp)*100, 0);
    sphereDetail(40);
  sphere(4);
  translate(-a[0]*sin(temp)*100, -b[0]*cos(temp)*100, 0);
*/
//  popMatrix(); 
  

}  
