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

public class sketch_140104b extends PApplet {

//\u30e9\u30f3\u30c0\u30e0\u306b\u5927\u304d\u3055\u3092\u8a2d\u5b9a\u3059\u308b\u3002
//\u30e9\u30f3\u30c0\u30e0\u306b\u30d6\u30e9\u30fc\u3092\u639b\u3051\u308b

PImage img;
float d, dMax;
boolean bool;
int interval;

public void setup() {
    size(300,300);
    background(0);    
    noStroke();
    frameRate(60);
    dMax = 400;
    d = 400;
    interval = 10;
    bool = true;
}
public void draw(){
    float x = width/2;
    float y = height/2;
    int grayScale = (int)(random(155));
    int r = (int)(random(155));
    int g = (int)(random(155));
    int b = (int)(random(155));

    int c = color(r,g,b);

    int blurLevel = 0;
    fill(grayScale);
    ellipse(x, y, d, d);
    filter(BLUR,blurLevel);

    if(bool){
        d -= interval;
        if(d < 0){
            d = dMax;
        }
    }
}
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "sketch_140104b" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
