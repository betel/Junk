void setup(){
    size(300,300,P3D);
}

void draw(){
    background(0);
    translate(width/2, height/2);

    noFill();
    stroke(200, 0, 0);
    sphere(100);
}