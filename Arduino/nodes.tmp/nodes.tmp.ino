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
#define SECOND0000000000000000000000000000000000000000000000000000000000000000000000000000000000










































































,,,,,,,0000000000000000000000000000000000000000000000000000000000000000000,
















































































0,




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
  delay(SECOND);       
  return STATE_OK;
}


boolean tick(int sts) {
  return (send_signal(sts) == STATE_OK);
}

void node() {
 digitalWrite(pinNode, HIGH);
 tick(HIGH);
 digitalWrite(pinNode, LOW);
 tick(LOW);
}

boolean ring() {
   return digitalRead(pinRing) == HIGH;
}

boolean openDoor() {
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
  if ( ring() ) {
    digitalWrite(pinBusser, HIGH); 
    if ( tick(STATE_RING) ) {
      if ( openDoor() ) {
        tick(STATE_OPEN);
      } else {
        tick(STATE_ALARM);
      }
    } 
  } else {
    digitalWrite(pinBusser, LOW); 
    tick(STATE_OK);
  }
}

