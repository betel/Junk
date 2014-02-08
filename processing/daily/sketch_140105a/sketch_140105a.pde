final int width = 401;
final int height = 401;

int cellsize = 20;
int cols = width/cellsize;
int rows = height/cellsize;
boolean[][] currentCell, nextCell;

static final int EDIT = 0;
static final int ANIMATION = 1;
static final int FPS = 10;
int mode;



void setup() {
    size(width, height);
    frameRate(FPS);
    mode = EDIT;
    //
    currentCell = new boolean[cols][rows];
    nextCell = new boolean[cols][rows];
    //
    clearCell();
}

void draw() { 
    background(0);
    if (mode == ANIMATION) {
        nextGeneration();
        updateCell();
    }
    drawCell();
}


void keyPressed() {
    if (key==' ') {
        if (mode==EDIT) {
            mode = ANIMATION;
        }
        else if (mode==ANIMATION) {
            mode = EDIT;
        }
    }

    if (key=='r') {
        randomInit();
    }
    if (key=='c') {
        clearCell();
    }
    if (key=='q') {
        exit();
    }
}

void mouseClicked() {
    if (mode == EDIT) {
        int x = (int)(mouseX / cellsize);
        int y = (int)(mouseY / cellsize);
        boolean tempBool = currentCell[x][y];
        if (tempBool) {
            currentCell[x][y] = false;
        }
        else {
            currentCell[x][y] = true;
        }
    }
}

void clearCell() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            currentCell[i][j] = false;
            nextCell[i][j] = false;
        }
    }
}

void randomInit() {
    for (int i=1; i<cols-1; i++) {
        for (int j=1; j<rows-1; j++) {
            int rand = (int)(random(2));
            if (rand==0) {
                currentCell[i][j] = false;
            }
            else if (rand==1) {
                currentCell[i][j] = true;
            }
        }
    }
}

void drawCell() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            if (currentCell[i][j]) {
                fill(0, 255, 0);
                stroke(127);
                rect(i*cellsize, j*cellsize, cellsize, cellsize);
            }
            else{
                fill(255);
                stroke(127);
                rect(i*cellsize, j*cellsize, cellsize, cellsize);
            }
        }
    }
}
void updateCell() {
    for (int i=0; i<cols; i++) {
        for (int j=0; j<rows; j++) {
            currentCell[i][j] = nextCell[i][j];
        }
    }
}
void nextGeneration() {  
    for (int i=1; i<cols-1; i++) {
        for (int j=1; j<rows-1; j++) {
            boolean b = currentCell[i][j];
            // boolean next = nextCell[i][j];
            int lives = countLife(i, j);

            if (!b) {
                if (lives==3) {
                    // next = true;
                    nextCell[i][j] = true;
                }
            }
            else {
                if (lives >= 4) {
                    // next = false;
                    nextCell[i][j] = false;
                }
                else if (lives >=2) {
                    // next = true;
                    nextCell[i][j] = true;
                }
                else {
                    // next = false;
                    nextCell[i][j] = false;
                }
            }
        }
    }
}
int countLife(int x, int y) {
    int count = 0;

    if (currentCell[x-1][y-1]) count++;
    if (currentCell[x  ][y-1]) count++;
    if (currentCell[x+1][y-1]) count++;
    if (currentCell[x-1][y  ]) count++;
    if (currentCell[x+1][y  ]) count++;
    if (currentCell[x-1][y+1]) count++;
    if (currentCell[x  ][y+1]) count++;
    if (currentCell[x+1][y+1]) count++;

    return count;
}

