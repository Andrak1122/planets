float a = 0;
boolean c = true;

void setup()
{
  size(500,500);
  frameRate(60);
}
void draw()
{
  background(250);
  
  fill(150,120,90);
  ellipse(250,250,490,490);
  fill(190,150,10);
  
/*
  if (c) {a += 1; if (a == 145) {c = false;}}
  if (!c) {a -= 1; if (a == 5) {c = true;}}
  ellipse(75,75,a,150-a);
*/

}
