// Importação da biblioteca de som
import processing.sound.*;

SoundFile sinoTibetano; //Declaração da variável de som
float[][] posicao, velocidade; 
float f1 = 0.01, f2 = 0.02, f3 = 0.03;
int[][] coordenada;
int largura, altura;
int meiaLargura, meiaAltura;

void setup() {
 
  sinoTibetano = new SoundFile(this,"sino.wav");
  size(800, 800);
  colorMode(RGB, 1);
  background(1);
  
  largura = width-1;
  altura = height-1;
  //Define a posição de inicio no centro da tela
  meiaLargura = width/2;
  meiaAltura = height/2;
  
  posicao = new float[width][height];
  velocidade = new float[width][height];
  
  coordenada = new int[width][height];
  int pixel = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      coordenada[x][y] = pixel++;
    }
  }
  
  loadPixels();
}

void draw() {
  velocidade[meiaLargura][meiaAltura] = 0;
  posicao[meiaLargura][meiaAltura] = (sin(frameCount * f1) + sin(frameCount * f2) + sin(frameCount * f3)) * 8;
  
  for (int x = 1; x < largura; x++) {
    for (int y = 1; y < altura; y++) {
      velocidade[x][y] += (posicao[x-1][y] + posicao[x+1][y] + posicao[x][y-1] + posicao[x][y+1]) * 0.25 - posicao[x][y];
    }
  }
  // Relação de movimento de um pixel com outro
  for (int x = 1; x < largura; x++) {
    for (int y = 1; y < altura; y++) {
      posicao[x][y] += velocidade[x][y];
      pixels[coordenada[x][y]] = color(1 - abs(constrain(posicao[x][y], -1, 1)));
    }
  }
  
  updatePixels();
}
//Função de clique
void mousePressed() {
  sinoTibetano.play();
  for (int x = 1; x < largura; x++) {
    for (int y = 1; y < altura; y++) {
      velocidade[x][y] = 0;
      posicao[x][y] = 0;
    }
  }


  
  f1 = random(0.5, 2);
  f2 = random(0.005, 0.05);
  f3 = random(0.005, 0.05);
}
