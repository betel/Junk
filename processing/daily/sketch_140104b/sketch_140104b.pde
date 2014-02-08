//ランダムに大きさを設定する。
//ランダムにブラーを掛ける

PImage img;
float d, dMax;
boolean bool;
int interval;

void setup() {
    size(300,300);
    background(0);    
    noStroke();
    frameRate(60);
    dMax = 400;
    d = 400;
    interval = 10;
    bool = true;
}
void draw(){
    float x = width/2;
    float y = height/2;
    int grayScale = (int)(random(155));
    int r = (int)(random(155));
    int g = (int)(random(155));
    int b = (int)(random(155));

    color c = color(r,g,b);

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