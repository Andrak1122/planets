float diff, xmag, ymag, newMWeel = 1, wheelMouse = 0, newXmag = 0, newYmag = 0;

// коэффици
int d = 200 * 5;

// год
float epoch = 2000;

// предыдущее время от начала запуска
int prevTime;

PImage skyImage;

// 1 a.e. = 149 597 870 км

float[] 
// ТАБЛИЦА СКОРОСТЕЙ ПЛАНЕТ
// Орбит. скорость (км/с)
speed = { 47.87, 35.02, 29.79, 24.13, 13.06, 9.66, 6.80, 5.44, 4.74, 0 } , 

// ТАБЛИЦА БОЛЬШИХ ПОЛУОСЕЙ ОРБИТ
// Большая полуось (а.е.)
a = { 0.387, 0.723, 1, 1.52, 5.2026, 9.5549, 19.218, 30.11038, 39.5181, 0.01 } , 

// ТАБЛИЦА МАЛЫХ ПОЛУОСЕЙ ОРБИТ
// Малая полуось (а.е.)
// заполним позже (в setup)
b = new float[10] ,  // Малая полуось (а.е.)

// Эксцентриситет
e = { 0.2056, 0.0067, 0.0167, 0.0934, 0.0484, 0.0555, 0.0462, 0.00898, 0.2459, 0 } , 

// (средняя долгота) угол на 2000 год
angle = { 253, 181, 100, 355, 34, 50, 314, 304, 0 , 0 } , 

// размеры планет в Землях
sizeOfPlanets = { 0.382, 0.949, 1.0, 0.53, 11.2, 9.41, 3.98, 3.81, 0.186, 109 / 25 } , 

// углы наклонов осей вращения планет в плоскости эклиптики
angleOfAxis = { 0, 177.36, 23.45, 25.19, 3.13, 25.33, 97.86, 28.31, 122.52, 50 } ,

// периоды обращений (в земных года)
periodsOfPlanets = { 0.241, 0.615, 1.0, 1.881, 11.857, 29.426, 83.749, 163.727, 248, 1.0 };


int zoomSize = 200;
int zoomRadius = zoomSize / 2;
int scaleSizeOfPlanet = 5;



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
	
	skyImage = loadImage("images/sky.jpg");
	prevTime = millis();
	
	frameRate(60);
	// b = new float[10];
	imageOfPlanet = new PImage[11];
	// imageOfPlanet[10] = loadImage("images/sky.jpg");
	sphereDetail(50);
	for (int i = 0; i <= 9; i++) {
		b[i] = a[i] * sqrt(1 - sq(e[i]));
		imageOfPlanet[i] = loadImage("images/im" + str(i) + ".jpg");
		sizeOfPlanets[i] = sizeOfPlanets[i] * scaleSizeOfPlanet;
		angle[i] = angle[i] / 180 * PI;
	}
	
	//imageOfPlanet = loadImage("http://localhost:5000/uploads/im"+".jpg");
	//imageOfPlanet = loadImage("sun.jpg");
	textureMode(NORMAL);
	
	
}

void mouseWheel(MouseEvent event) {
	wheelMouse += event.getCount();
	if (wheelMouse >= 12) {
		wheelMouse = 11;
	}
}
void planets() {
	for (int num = 0; num <= 9; num++) {
		if (keyPressed != true) {
			epoch++;
			angle[num] = (angle[num] + (1) / periodsOfPlanets[num] * TWO_PI * 0.01);
		}
	}
}

void planetsdraw() {
	for (int num = 0; num <= 9; num++) {
		// рисуем орбиту (эллипс)
		noFill();
		stroke(255, 255, 255, 128);
		ellipse(0, 0, a[num] * zoomSize, b[num] * zoomSize);
		
		// рисуем подписи к планете
		translate(a[num] * sin(angle[num]) * zoomRadius, b[num] * cos(angle[num]) * zoomRadius, 0);
		rotateZ(PI);
		fill(255, 0, 0);
		if (wheelMouse > 6 && num > 3) {
			textSize(20 * wheelMouse);
			text(names[num], sizeOfPlanets[num] * wheelMouse + 10, sizeOfPlanets[num] * wheelMouse + 10);
			fill(255);
		} else {
			textSize(20);
			text(names[num], sizeOfPlanets[num] + 10, sizeOfPlanets[num] + 10);
			fill(255);
		}
		
		rotateZ( -PI);
		rotateX(PI / 2);
		rotateZ(PI * angleOfAxis[num] / 360);
		
		// рисуем планету
		
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
		translate( -a[num] * sin(angle[num]) * zoomRadius, -b[num] * cos(angle[num]) * zoomRadius, 0);
	}
	float alfa = wheelMouse;
	if (alfa <= 0) { 
		alfa = 1;}
	PShape sp = createShape(SPHERE, 2000 * alfa);
	sp.setStroke(false);
	sp.setTexture(skyImage);
	shape(sp);
}



void draw() {
	float fps = (1000 / (millis() - prevTime));
	prevTime = millis();
	// epoch++;
	// background(imageOfPlanet[10]);
	// background(skyImage);
	background(0);
	textSize(20);
	fill(0,255,0);
	text(str(fps) + ' ' + str(epoch), 10 , 30);
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
	scale(newMWeel - wheelMouse / 10);
	rotateX( -ymag);
	rotateY( -xmag);
	planetsdraw();
}
