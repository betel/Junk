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

public class sketch_131209a extends PApplet {

public void setup(){
    size(300,300,P3D);
}

public void draw(){
    background(0);
    translate(width/2, height/2);

    noFill();
    stroke(200, 0, 0);
    sphere(100);
}
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "sketch_131209a" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
