float v = 0.001;
long lastFrameTime;
long lastFrame; //for counting FPS
int lastFPS;
int fps;
float angle;

PFont font;

void setup() {
    size(300, 300, P3D);
    lastFrameTime = 0;
    lastFrame = 0;
    angle = 0;
    fps = 0;
    getDelta();
    
    font = loadFont("Ricty-Regular-48.vlw");
    textFont(font,32);
}

void draw() {
    background(0);
    
    fill(255);
    String dispFPS = "FPS:" + fps();
    text(dispFPS,10,30);
    
    
    pushMatrix();
    translate(width/2, height/2);
    rotateY(angle);
    fill(200, 0, 0, 80);
    stroke(255, 0, 0);
    box(80, 150, 40);
    int delta = getDelta();
    angle += v*delta;
    popMatrix();
}

int getDelta() {
    long currentTime = millis();
    int delta = (int)(currentTime - lastFrameTime);
    lastFrameTime = currentTime;
    return delta;
}

int fps() {
    long currentMillis = millis();
    if ((currentMillis - lastFrame) > 1000) {
        lastFPS = fps;
        lastFrame = currentMillis;
        fps = 0;
        return lastFPS;
    }
    else {
        fps++;
        return lastFPS;
    }
}

