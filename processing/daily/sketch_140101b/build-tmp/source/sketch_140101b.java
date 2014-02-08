import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_140101b extends PApplet {

final int width = 401;
final int height = 401;
final int cellsize = 10;

PFont font;

int cols, rows;
boolean[][] life, nextLife;
int fps;

public void setup() {
    size(width, height);
    fps = 10;

    font = loadFont("Monaco-48.vlw");

    cols = width/cellsize;
    rows = height/cellsize;
    life = new boolean[cols][rows];
    nextLife = new boolean[cols][rows];
    //\u5168\u3066\u6b7b\u3067\u521d\u671f\u5316\u3059\u308b
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            life[i][j] = false;
            nextLife[i][j] = false;
        }
    }
    //\u30e9\u30f3\u30c0\u30e0\u306b\u521d\u671f\u5316\u3059\u308b
    randomInit();
}

//\u6b7b\u3093\u3067\u3044\u308b\u30bb\u30eb\u306f\u5857\u308a\u3064\u3076\u3055\u306a\u3044\u3053\u3068\u3067\u8868\u73fe\u3059\u308b
//\u5e38\u306b\u73fe\u5728\u306e\u4e16\u4ee3\u3092\u63cf\u753b\u3059\u308b
public void draw() {
    frameRate(fps);
    background(0);
    dispFPS();
    nextGeneration();
    updateGeneration();
    drawCells();
}

public void drawCells() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            if (life[i][j]) {
                fill(255);
                stroke(0, 0, 0);
                rect(i*cellsize, j*cellsize, cellsize, cellsize);
            }
            
        }
    }
}
//\u6b21\u306e\u4e16\u4ee3\u306e\u5185\u5bb9\u3092\u73fe\u5728\u306e\u4e16\u4ee3\u306b\u30b3\u30d4\u30fc
public void updateGeneration() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            life[i][j] = nextLife[i][j];
        }
    }
}

//\u751f\u6b7b\u5224\u5225
public void nextGeneration() {
    for (int i=1; i<cols-1; i++) {
        for (int j=1; j<rows-1; j++) {
            int alive = countLife(i, j);
            //\u5bfe\u8c61\u306e\u30bb\u30eb\u304c\u6b7b\u3093\u3067\u3044\u308b\u6642
            if (!life[i][j]) {
                if (alive == 3) {
                    nextLife[i][j] = true;
                }
            }
            else {//\u751f\u304d\u3066\u3044\u308b\u6642
                if (alive>=4) {
                    nextLife[i][j] = false;
                }
                else if (alive >=2) {
                    nextLife[i][j] = true;
                }
                else {
                    nextLife[i][j] = false;
                }
            }
        }
    }
}
//\u751f\u304d\u3066\u308b\u30bb\u30eb\u306e\u30ab\u30a6\u30f3\u30c8
public int countLife(int a, int b) {
    int count = 0;

    if (life[a-1][b-1]) count++;
    if (life[a  ][b-1]) count++;
    if (life[a+1][b-1]) count++;
    if (life[a-1][b  ]) count++;
    if (life[a+1][b  ]) count++;
    if (life[a-1][b+1]) count++;
    if (life[a  ][b+1]) count++;
    if (life[a+1][b+1]) count++;

    return count;
}

//\u30e9\u30f3\u30c0\u30e0\u3067\u521d\u671f\u5316\u3059\u308b
public void randomInit() {
    for (int i=1; i<cols-1; i++) {
        for (int j=1; j<rows-1; j++) {

            int r = (int)(random(0, 2));
            if (r == 0) {
                life[i][j] = false;
            }
            else {
                life[i][j] = true;
            }
        }
    }
}

//\u30ad\u30fc\u304c\u62bc\u3055\u308c\u305f\u6642\u306e\u52d5\u4f5c
//r:\u30e9\u30f3\u30c0\u30e0\u3067\u521d\u671f\u5316
//k:\u63cf\u753b\u3092\u52a0\u901f j:\u63cf\u753b\u3092\u6e1b\u901f
//  
public void keyPressed() {
    if (key == 'r') {
        randomInit();
    }
    if (key == 'h') fps = 10;
    if (key == 'l') fps = 60;
    if (key == 'k') fps += 2;
    
    if (key == 'j') {
        fps -= 2;
        if (fps<=1) {
            fps = 1;
        }
    }
    
    if(key == 'q') exit();
}

//FPS\u3092\u8868\u793a\u3059\u308b
public void dispFPS() {
    fill(255, 0, 0);
    textFont(font, 13);
    text("FPS:" + fps, width - 55, 20);
}

    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "sketch_140101b" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
