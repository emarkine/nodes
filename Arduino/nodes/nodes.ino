/**
 * node door 
 * 
 * If the call rings then message will send to Nodes system. 
 * If arduino receive a right response from Nodes then the door will open.
 * 
 * EugeneLab 2017
 */

#define MILISECOND       1
#define MILISECONDS      100
#define SECOND           1000
#define SECONDS          5000
#define PIN_BUTTON      2
#define PIN_RELAY       3
#define PIN_NODE        5

#define STATE_PAUSE   0
#define STATE_OK      1
#define STATE_RING    2
#define STATE_OPEN    3
#define STATE_CLOSE   4
#define STATE_START   5
#define STATE_ALARM  -9


const int pinNode = PIN_NODE;
const int pinRing = PIN_BUTTON;
const int pinDoor = PIN_RELAY;
const int pinLed = LED_BUILTIN;
const int pinBusser = 6;
int state = STATE_PAUSE;

/**
 * Comunicate with server  
 */
int send_signal(int sts) {
  Serial.println("node door "+ sts); 
  delay(MILISECONDS);       
  return STATE_OK;
}


boolean tick(int status) {
  return send_signal(status) == STATE_OK;
}


void node() {
 digitalWrite(pinNode, HIGH);
 tick(HIGH);
 digitalWrite(pinNode, LOW);
 tick(LOW);
}

/**
 * что-то пошло не так :-)
 */
void alarm() {
  send_signal(STATE_ALARM); // будим управляющего
}


/**
 * the door ring is pushed
 */
boolean isRing() {
  if ( digitalRead(pinRing) == HIGH ) { // if the door ring is pushed
    tick(STATE_RING); // the signal is sending to nodes
    digitalWrite(pinBusser, HIGH); 
    delay(SECOND);       
    digitalWrite(pinBusser, LOW); 
    return true;
  } else {
    return false;
  }
}


/**
 * somebody at home 
 */

boolean isHome() {
  delay(SECONDS);       
}


/**
 * the door is opening
 */
boolean isDoor() {
  digitalWrite(pinDoor, HIGH);
  tick(STATE_OPEN);
  delay(SECONDS);       
  digitalWrite(pinDoor, LOW);
  tick(STATE_CLOSE);
  return true;
}

void setup() {
 pinMode(pinNode, OUTPUT);
 pinMode(pinRing, INPUT);
 pinMode(pinBusser, OUTPUT);  
 pinMode(pinDoor, OUTPUT);
 pinMode(pinLed, OUTPUT);  
 digitalWrite(pinLed, LOW); 
 tick(STATE_OK);
}

void loop() {
  if ( isRing() ) { 
    if ( !isHome() ) {  
      if ( !isDoor() ) {
        alarm();
      }
    } 
  } else {
    node();
  }
}

