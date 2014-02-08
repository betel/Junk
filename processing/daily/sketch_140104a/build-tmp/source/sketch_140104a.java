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

public class sketch_140104a extends PApplet {

//\u56de\u8ee2\u89d2\u5ea6\u306b\u3088\u3063\u3066\u8272\u304c\u5909\u5316\u3059\u308b\u3088\u3046\u306b\u3057\u3066\u307f\u308b

PFont font;
float angle;
float velocity = 0.005f;
int lastFrameTime;

public void setup(){
    size(300,300,P3D);
    font = loadFont("Monaco-72.vlw");
    smooth();
    angle = 0;
}

public void draw(){
    float delta = getDelta();
    background(255);
    translate(width/2,height/2,0);

    pushMatrix();
    rotateY(angle);
    fill(255,0,255);
    textFont(font,72);
    textAlign(CENTER);
    text("3D",0,0);
    popMatrix();

    pushMatrix();
    rotateY(-angle*0.1f);
    fill(255,0,0);
    noStroke();
    rectMode(CENTER);
    rect(0,0,100,100);
    popMatrix();

    angle -= velocity*delta;
}

public float getDelta(){
    int currentTime = millis();
    float delta = currentTime - lastFrameTime;
    lastFrameTime = currentTime;
    return delta;
}
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "sketch_140104a" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
