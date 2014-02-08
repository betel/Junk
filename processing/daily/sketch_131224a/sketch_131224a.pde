long lastFrameTime = 0;
float angle = 0;
float velocity = 0.001;
void setup() {
    size(300, 300, P3D);
    smooth();
}

void draw() {
    background(0);
    int delta = getDelta();
    angle += velocity*delta;
    beginCamera();
    camera();
    rotate(angle);
    endCamera();
    
    translate(width/2, height/2, 0);
    rotateX(-PI/6);
    noFill();
    stroke(255);
    box(50);
}

int getDelta(){
    long currentTime = millis();
    int delta = (int)(currentTime - lastFrameTime);
    lastFrameTime = currentTime;
    return delta;
}
