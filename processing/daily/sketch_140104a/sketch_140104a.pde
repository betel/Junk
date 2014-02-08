//回転角度によって色が変化するようにしてみる

PFont font;
float angle;
float velocity = 0.005;
int lastFrameTime;

void setup(){
    size(300,300,P3D);
    font = loadFont("Monaco-72.vlw");
    smooth();
    angle = 0;
}

void draw(){
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
    rotateY(-angle*0.1);
    fill(255,0,0);
    noStroke();
    rectMode(CENTER);
    rect(0,0,100,100);
    popMatrix();

    angle -= velocity*delta;
}

float getDelta(){
    int currentTime = millis();
    float delta = currentTime - lastFrameTime;
    lastFrameTime = currentTime;
    return delta;
}
