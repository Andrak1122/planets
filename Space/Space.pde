float diff, xmag, ymag, newMWeel = 1, weelmause = 0, newXmag = 0, newYmag = 0;

int d = 200 * 5;

// 1 a.e. = 149 597 870 км

float[] 
// ТАБЛИЦА СКОРОСТЕЙ ПЛАНЕТ
// Орбит. скорость (км/с)
speed = { 47.87, 35.02, 29.79, 24.13, 13.06, 9.66, 6.80, 5.44, 4.74, 0 } , 

// ТАБЛИЦА БОЛЬШИХ ПОЛУОСЕЙ ОРБИТ
// Большая полуось (а.е.)
a = { 0.387, 0.723, 1, 1.52, 5.2026, 9.5549, 19.218, 30.11038, 39.5181, 0.01 } , 

b, // Малая полуось (а.е.)
e = { 0.2056, 0.0067, 0.0167, 0.0934, 0.0484, 0.0555, 0.0462, 0.00898, 0.2459, 0 } , // Эксцентриситет
angle = { 253, 181, 100, 355, 34, 50, 314, 304, 0 , 0 } , // (средняя долгота) угол на 2000 год
sizeOfPlanets = { 2.440 * 2, 6.052 * 2, 6.378 * 2, 3.397 * 2, 71.490, 60.270, 25.560, 24.760, 1.151, 20 } , // размеры планет
angleOfAxis = { 0, 177.36, 23.45, 25.19, 3.13, 25.33, 97.86, 28.31, 122.52, 50 };

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

PImage[] imageOfPlanet;

void setup() {
	size(1920, 1000, P3D);
	
	frameRate(60);
	b = new float[10];
	imageOfPlanet = new PImage[11];
	imageOfPlanet[10] = loadImage("images/sky.jpg");
	sphereDetail(50);
	for (int i = 0; i <= 9; i = i + 1) {
		b[i] = a[i] * sqrt(1 - sq(e[i]));
		imageOfPlanet[i] = loadImage("images/im" + str(i) + ".jpg");
	}
	
	//imageOfPlanet = loadImage("http://localhost:5000/uploads/im"+".jpg");
	//imageOfPlanet = loadImage("sun.jpg");
	textureMode(NORMAL);
	
	
}

void mouseWheel(MouseEvent event) {
	weelmause += event.getCount();
	if (weelmause >= 12) {
		weelmause = 11;
	}
}
void planets() {
	for (int num = 0; num <= 9; num += 1) {
		if (keyPressed != true) {
			angle[num] = (angle[num] + speed[num] / (PI * d)) % TWO_PI;
		}
	}
}
void planetsdraw() {
	for (int num = 0; num <= 9; num += 1) {
		noFill();
		stroke(255, 255, 255, 128);
		ellipse(0, 0, a[num] * 200, b[num] * 200);
		fill(255);
		
		translate(a[num] * sin(angle[num]) * 100, b[num] * cos(angle[num]) * 100, 0);
		rotateZ(PI);
		fill(255, 0, 0);
		if (weelmause > 6 && num > 3) {
			textSize(20 * weelmause);
			sizeOfPlanets[num] = sizeOfPlanets[num] * weelmause;
			text(names[num], sizeOfPlanets[num] + 10, sizeOfPlanets[num] + 10);
			sizeOfPlanets[num] = sizeOfPlanets[num] / weelmause;
			fill(255);
		} else {
			textSize(20);
			text(names[num], sizeOfPlanets[num] + 10, sizeOfPlanets[num] + 10);
			fill(255);
		}
		
		rotateZ( -PI);
		rotateX(PI / 2);
		rotateZ(PI * angleOfAxis[num] / 360);
		
		// beginShape();
		// texture(imageOfPlanet);
		PShape sp = createShape(SPHERE, sizeOfPlanets[num]);
		sp.setStroke(false);
		sp.setTexture(imageOfPlanet[num]);
		shape(sp);
		//sphere(sizeOfPlanets[num]);
		//endShape();
		
		rotateZ( -PI * angleOfAxis[num] / 360);
		rotateX( -PI / 2);
		translate( -a[num] * sin(angle[num]) * 100, -b[num] * cos(angle[num]) * 100, 0);
	}
	float alfa = weelmause;
	if (alfa <= 0) { 
		alfa = 1;}
	PShape sp = createShape(SPHERE, 2000 * alfa);
	sp.setStroke(false);
	sp.setTexture(imageOfPlanet[10]);
	shape(sp);
}
void draw() {
	background(imageOfPlanet[10]);
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
	rotateX( -ymag);
	rotateY( -xmag);
	planetsdraw();
}
