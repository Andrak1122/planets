float a = 0;
boolean c = true;

void setup()
{
  size(150,150);
  frameRate(60);
}
void draw()
{
  background(250);
  
  fill(150,120,90);
  ellipse(75,75,120,120);
  fill(190,150,10);
  
  /*
  if (c) {a += 1; if (a == 145) {c = false;}}
  if (!c) {a -= 1; if (a == 5) {c = true;}}
  ellipse(75,75,a,150-a);
  */

}
