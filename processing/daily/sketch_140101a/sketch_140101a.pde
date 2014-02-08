final int width = 701;
final int height = 701;
final int cellsize = 10;
final int maxLevel = 7;

PFont font;

int cols, rows;
// boolean[][] life, nextLife;
int[][] life, nextLife;

int fps;

void setup() {
	size(width, height);
	fps = 10;

	font = loadFont("Monaco-48.vlw");

	cols = width/cellsize;
	rows = height/cellsize;
	// life = new boolean[cols][rows];
	life = new int[cols][rows];
	// nextLife = new boolean[cols][rows];
	nextLife = new int[cols][rows];

	//全て死で初期化する
	for (int i=0; i<cols; i++) {
		for (int j=0; j<rows; j++) {
			// life[i][j] = false;
			life[i][j] = 0;
			// nextLife[i][j] = false;
			nextLife[i][j] = 0;
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
			int level = life[i][j];
			if (level==1) {
				fill(0,150,0);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==2){
				fill(100,255,0);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==3){
				fill(255,255,0);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==4){
				fill(255,100,0);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==5){
				fill(255,0,0);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==6){
				fill(255,0,255);
				stroke(0);
				rect(i*cellsize, j*cellsize, cellsize, cellsize);
			}
			else if(level==7){
				fill(255,255,255);
				stroke(0);
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
//トーラスをやめるには1~cols-1の範囲にする
void nextGeneration() {
	for (int i=1; i<cols-1; i++) {
		for (int j=1; j<rows-1; j++) {
			int alive = countLife(i, j);
			int level = life[i][j];

			//対象のセルが死んでいる時
			if (level==0) {
				if (alive == 3) {
					nextLife[i][j] = 1;
				}
			}
			else {//生きている時
				if (alive>=4) {
					nextLife[i][j] = 0;
				}
				else if (alive >=2) {
					nextLife[i][j] = level + 1;//生存レベルを上げる
					if(level>=maxLevel){		//レベルはmaxLevelまで
						nextLife[i][j] = maxLevel;
					}
				}
				else {
					nextLife[i][j] = 0;
				}
			}
		}
	}
}
//生きてるセルのカウント
int countLife(int a, int b) {
	int count = 0;

	if (life[a-1][b-1] >=1) count++;
	if (life[a  ][b-1] >=1) count++;
	if (life[a+1][b-1] >=1) count++;
	if (life[a-1][b  ] >=1) count++;
	if (life[a+1][b  ] >=1) count++;
	if (life[a-1][b+1] >=1) count++;
	if (life[a  ][b+1] >=1) count++;
	if (life[a+1][b+1] >=1) count++;

	return count;
}

//ランダムで初期化する
void randomInit() {
	for (int i=1; i<cols-1; i++) {
		for (int j=1; j<rows-1; j++) {

			int r = (int)(random(0, 2));
			if (r == 0) {
				life[i][j] = 0;
			}
			else {
				life[i][j] = 1;
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

