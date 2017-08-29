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
#define PIN_BUTTON       2
#define PIN_RELAY        3
#define PIN_NODE         5
#define PIN_BUSSER       6

#define STATE_PAUSE   0
#define STATE_OK      1
#define STATE_RING    2
#define STATE_OPEN    3
#define STATE_CLOSE   4
#define STATE_SIGNAL -8
#define STATE_ALARM  -9

#define BUTTON 2

#define OFF         0
#define ON          1
#define BUTTON_PUSH 2


const int pinNode = PIN_NODE;
//const int pinAlarm = PIN_BUTTON;
const int pinButton = PIN_BUTTON;
//const int pinDoor = PIN_RELAY;
const int pinRelay = PIN_RELAY;
const int pinLed = PIN_NODE;
const int pinBusser = PIN_BUSSER;
const int frame = SECOND;
int state = STATE_PAUSE;

/**
 * Comunicate with server  
 */
int send_signal(int sts) {
  Serial.println(sts); 
  delay(frame);       
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
  state = STATE_ALARM;
  send_signal(STATE_ALARM); // будим управляющего
  busser(); // включаем тревогу пока он ее не выключат кнопкой
}

void busser() {
  if ( state == STATE_ALARM ) {
    tone(pinBusser, 500);   
    delay(100);
    tone(pinBusser, 1000);   
    delay(100);
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
//boolean isDoor() {
//  digitalWrite(pinDoor, HIGH);
//  tick(STATE_OPEN);
//  delay(SECONDS);       
//  digitalWrite(pinDoor, LOW);
//  tick(STATE_CLOSE);
//  return true;
//}

/**
 * is sound signal
 */
boolean isSignal() {
  int signal = analogRead(A0);
  tick(STATE_SIGNAL);
  if ( signal > 60 ) {
    return true;
  } 
  return false;
}

/**
 * the alarm button is pushed
 */
//boolean isAlarm() {
//  if ( digitalRead(pinAlarm) == HIGH ) { // if the door ring is pushed
//    state = STATE_ALARM; 
//    return true;
//  }
//  return false;
//}

/**
 * button pushed
 */
boolean isButton() {
  if ( digitalRead(pinButton) == HIGH ) { // if the door ring is pushed
    tick(BUTTON_PUSH); // the signal is sending to nodes
    return true;
  } else {
    return false;
  }
}


void reley(int sts)
{
  if ( sts == ON ) {
    digitalWrite(pinRelay, HIGH);
  } else {
    digitalWrite(pinRelay, LOW);
  }
  
}


void setup() {
  pinMode(A0,INPUT);
  pinMode(pinNode, OUTPUT);
//  pinMode(pinAlarm, INPUT);
  pinMode(pinButton, INPUT);
  pinMode(pinBusser, OUTPUT);  
  pinMode(pinRelay, OUTPUT);
  pinMode(pinLed, OUTPUT);  
  digitalWrite(pinNode, LOW); 
  Serial.begin(9600);
}

void loop() {
//  if ( isAlarm() ) {
//    alarm();
//  }
//  if ( isRing() ) { // ring button pushed
//    if ( !isHome() ) { // you are not home 
//      if ( !isDoor() ) { // start alarm system if dor not opened or closed
//        alarm(); // send signal to the 
//      }
//    } 
  if ( isButton() ) {
    reley(ON);
//    alarm();
  } else {
    reley(OFF);
    node();
  }
}

