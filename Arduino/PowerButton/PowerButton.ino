#include <PowerButton.h>
 
#define POWER_PIN_SIG  2
#define POWER_PIN_VCC  4
#define POWER_FET_GATE 5
#define POWER_PIN_INT  0
 
PowerButtonSwitch pbs;
 
void onPowerOn(){
  Serial.println("Power On");
  digitalWrite(POWER_FET_GATE, 1);  // Открываем затвор (gate)
}
 
void onPowerOff(){
  Serial.println("Power Off");
  digitalWrite(POWER_FET_GATE, 0);  // Закрываем затвор (gate)
}
 
void setup() {
Serial.begin(9600);  
 
  // Вывод сигнала от Arduino к затвору MOSFET (gate)
  pinMode(POWER_FET_GATE, OUTPUT);
  digitalWrite(POWER_FET_GATE, 0);
 
  // Начальная настройка кнопки питания
  pbs.setupPowerButton(POWER_PIN_SIG, POWER_PIN_VCC, POWER_PIN_INT);
 
  // Считываем текущее значение
  // Если есть сигнал от кнопки,
  // включаем Raspberry Pi
  int st = pbs.getSwitchStatus();
  if (st == POWER_ON) {
    onPowerOn();
  }
 
  // Добавляем обработчики событий
  pbs.onPowerOn(onPowerOn);
  pbs.onPowerOff(onPowerOff);
}

void loop() {
  delay(1000);
  Serial.println("No actions");
  }
