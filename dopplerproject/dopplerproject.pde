float[][] p, v;
int[][] unicoord;
int widt, heigh;
int halfWidth, halfHeight;

void setup() {
  size(600, 600);
  colorMode(RGB, 1);
  background(1);
  
  widt = width-1;
  heigh = height-1;
  
  halfWidth = width/2;
  halfHeight = height/2;
  
  p = new float[width][height];
  v = new float[width][height];
  
  unicoord = new int[width][height];
  int pixel = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      unicoord[x][y] = pixel++;
    }
  }
  
  loadPixels();
}

void draw() {
  v[halfWidth][halfHeight] = 0;
  p[halfWidth][halfHeight] = (sin(frameCount * 0.01) + sin(frameCount * 0.1)) * 8;
  
  for (int x = 1; x < widt; x++) {
    for (int y = 1; y < heigh; y++) {
      v[x][y] += (p[x-1][y] + p[x+1][y] + p[x][y-1] + p[x][y+1]) * 0.25 - p[x][y];
    }
  }
  
  for (int x = 1; x < widt; x++) {
    for (int y = 1; y < heigh; y++) {
      p[x][y] += v[x][y];
      float velocityColor = 1 - abs(constrain(v[x][y], -1, 1));
      pixels[unicoord[x][y]] = color(1 - abs(constrain(p[x][y], -1, 1)), velocityColor, velocityColor);
    }
  }
  
  updatePixels();
}
