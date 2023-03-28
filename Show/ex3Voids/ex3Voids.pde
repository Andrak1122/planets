
float wheel;

void setup()
{
  size(400,400);
  frameRate(60);
}

void mouseWheel(MouseEvent event) {
  wheel += event.getCount();
}

void drawEllipse()
{
  
  ellipse(0,0,100,100);
  
}

void draw()
{
  background(250);
  println(wheel);
  translate(height/2,width/2);
  scale(1+0.1*wheel);
  drawEllipse();
  
}
