final int width = 401;
final int height = 401;
final int cellsize = 10;

PFont font;

int cols, rows;
boolean[][] life, nextLife;
int fps;

void setup() {
    size(width, height);
    fps = 10;

    font = loadFont("Monaco-48.vlw");

    cols = width/cellsize;
    rows = height/cellsize;
    life = new boolean[cols][rows];
    nextLife = new boolean[cols][rows];
    //全て死で初期化する
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            life[i][j] = false;
            nextLife[i][j] = false;
        }
    }
    //ランダムに初期化する
    randomInit();
}

//死んでいるセルは塗りつぶさないことで表現する
//常に現在の世代を描画する
void draw() {
    frameRate(fps);
    background(0);
    dispFPS();
    nextGeneration();
    updateGeneration();
    drawCells();
}

void drawCells() {
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
//次の世代の内容を現在の世代にコピー
void updateGeneration() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            life[i][j] = nextLife[i][j];
        }
    }
}

//生死判別
void nextGeneration() {
    for (int i=1; i<cols-1; i++) {
        for (int j=1; j<rows-1; j++) {
            int alive = countLife(i, j);
            //対象のセルが死んでいる時
            if (!life[i][j]) {
                if (alive == 3) {
                    nextLife[i][j] = true;
                }
            }
            else {//生きている時
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
//生きてるセルのカウント
int countLife(int a, int b) {
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

//ランダムで初期化する
void randomInit() {
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

//キーが押された時の動作
//r:ランダムで初期化
//k:描画を加速 j:描画を減速
//  
void keyPressed() {
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

//FPSを表示する
void dispFPS() {
    fill(255, 0, 0);
    textFont(font, 13);
    text("FPS:" + fps, width - 55, 20);
}

