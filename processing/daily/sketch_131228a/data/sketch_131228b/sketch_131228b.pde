import processing.serial.*;

PFont font;
int interval = 1;
int lastTime;

Serial port;
String buffer = "";
String str;

void setup() {
    frameRate(10);

    String arduinoPort = Serial.list()[7];

    port = new Serial(this, arduinoPort, 9600);

    lastTime = 0;
}

void draw() {
    background(0);
    int n = (int)(interval - ((millis() - lastTime)/1000));

    if (n <= 0) {
        println(buffer);
        lastTime = millis();
    }

    if (port.available() > 0) {
        int inByte = port.read();
        if (inByte != 10) {            
            buffer += char(inByte);
        }
        else {
            if (buffer.length() > 1) {
                buffer = buffer.substring(0, buffer.length() -1);
                str = buffer;
                buffer = "";
                port.clear();
            }
        }
    }
}

