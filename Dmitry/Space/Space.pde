// ТАБЛИЦА СКОРОСТЕЙ ПЛАНЕТ

float[] speed =
{
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
  };
  
float[]   a =
  {
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
  };
  float[] e =
  {
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
  };

// ТАБЛИЦА КООРДИНАТ ПЛАНЕТ
  float[] coordinate_of_planet =
  {
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
  };
  float[] sizeofplanets =
  {
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
  };
  float[] angle =
  {
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

String[] names =
{
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

String[] image_names =
{
  "im/im0.jpg",
  "im/im1.jpg",
  "im/im2.jpg",
  "im/im3.jpg",
  "im/im4.jpg",
  "im/im5.jpg",
  "im/im6.jpg",
  "im/im7.jpg",
  "im/im8.jpg",
  "im/im9.jpg",
  "im/sky/2.jpg"
};

int planets_num = 10;
int images_num = planets_num+1;

PImage[] im = new PImage[images_num];
PShape[] planets_shapes = new PShape[planets_num];
float[] b = new float[planets_num];

float xmag, ymag, weelmause = 0, xy_scale = 1;
int d = 200 * 5;

void setup()
{
  for (int i = 0; i < images_num; i = i + 1)
  {
    // ЗАГРУЗИТЬ КАРТИНКИ ПОВЕРХНОСТЕЙ ПЛАНЕТ
    im[i] = loadImage(image_names[i]);
  }

  for (int i = 0; i < planets_num; i = i + 1)
  {
    b[i] = a[i] * sqrt(1 - sq(e[i]));

    // ИНИЦИАЛИЗИРОВАТЬ ИЗОБРАЖЕНИЯ ПЛАНЕТ
    planets_shapes[i] = createShape(SPHERE, sizeofplanets[i]);
    planets_shapes[i].setStroke(false);
    planets_shapes[i].setTexture(im[i]);
}


 // УСТАНОВИТЬ РАЗМЕР ЭКРАНА
  size(1920, 1000, P3D);
  frameRate(60);
  textureMode(NORMAL);
  sphereDetail(50);
  im[10].resize(width, height);
}

void mouseWheel(MouseEvent event)
{
 // ВЗЯТЬ СЧЁТЧИК ПОВОРОТА СРЕДНЕГО КОЛЕСА МЫШИ
  weelmause += event.getCount();
}

void calculate()
{
  // ПЕРЕСЧИТАТЬ ПОЗИЦИИ ПЛАНЕТ
  for (int num = 0; num < planets_num; num = num + 1)
  {
    if (keyPressed != true)
    {
        coordinate_of_planet[num] = (coordinate_of_planet[num] + speed[num] / (PI * d)) % TWO_PI;
    }
  }

  // ПЕРЕСЧИТАТЬ МАСШТАБ СИСТЕМЫ КООРДИНАТ ВСЕЛЕННОЙ
  if (weelmause >= 18)
  {
    weelmause = 17;
  }
  xy_scale = 1 - weelmause / 10;


  // ПЕРЕСЧИТАТЬ ПОВОРОТ СИСТЕМЫ КООРДИНАТ ВСЕЛЕННОЙ
 if (mousePressed && (mouseButton == LEFT))
  {
    float newXmag = mouseX / float(width) * TWO_PI;
    float newYmag = mouseY / float(height) * TWO_PI;
    float diff = xmag - newXmag;
    xmag = xmag - (diff / 4.0);
    diff = ymag - newYmag;
    ymag = ymag - (diff / 4.0);
  }
}

void planetsdraw()
{
  // ОРИЕНТИРОВАТЬ СИСТЕМУ КООРДИНАТ ВСЕЛЕННОЙ
  translate(width / 2, height / 2, -30);
  scale(xy_scale);
  rotateX(ymag);
  rotateY(xmag);
  
  // НАРИСОВАТЬ НЕБО
  background(im[10]);

  // НАРИСОВАТЬ ПЛАНЕТЫ
  for (int num = 0; num < planets_num; num = num + 1)
  {
    // СОХРАНИТЬ СИСТЕМУ КООРДИНАТ ВСЕЛЕННОЙ
    pushMatrix();

    // РАЗМЕСТИТЬ ОРБИТУ
    noFill();
    stroke(255, 255, 255,30);
    ellipse(0, 0, a[num] * 200, b[num] * 200);
    fill(255);

    // ОРИЕНТИРОВАТЬ СИСТЕМУ КООРДИНАТ ПЛАНЕТЫ
    translate(a[num] * sin(coordinate_of_planet[num]) * 100, b[num] * cos(coordinate_of_planet[num]) * 100, 0);
    // РАЗМЕСТИТЬ ПЛАНЕТУ
    shape(planets_shapes[num]);

    // РАЗМЕСТИТЬ ТЕКСТ
    textSize(20);
    fill(255,0,51);
    text(names[num], sizeofplanets[num] + 10, sizeofplanets[num] + 10);
    
    // ВОССТАНОВИТЬ СИСТЕМУ КООРДИНАТ ВСЕЛЕННОЙ
    popMatrix();
  }

}
void draw()
{
  // СДЕЛАТЬ ВСЕ РАСЧЁТЫ
  calculate();
  // ВЫПОЛНИТЬ ОТРИСОВКУ
  planetsdraw();
}
