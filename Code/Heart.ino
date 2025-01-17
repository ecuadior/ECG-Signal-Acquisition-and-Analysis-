void setup() {
  Serial.begin(9600);  // Initialize serial communication
}

void loop() {
  
  int sensorValue = analogRead(A0);  // Read the value from analog pin A0
  Serial.println(sensorValue);  // Send the value to the serial port
  delay(100);// Delay to avoid flooding the serial port
}
