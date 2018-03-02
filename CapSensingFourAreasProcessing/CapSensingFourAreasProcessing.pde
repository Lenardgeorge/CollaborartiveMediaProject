import processing.serial.*;

import processing.pdf.*;
import java.util.Calendar;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
long temp;
//int integerVal= 1;
int integerValZ= 1;
int integerValY= 1;
int integerValX= 1;
int integerValW= 1;

boolean savePDF = false;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
   size(1080, 720);
   noCursor();
}

void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
   val = myPort.readStringUntil('\n');         // read it and store it in val
   //temp = Long.valueOf(val);
   if(val != null && val != ""){
       char c = val.charAt(0); //takes the first letter of the string (to check from which CapSensor it comes)
       String val2 = val.substring(1); //removes the first letter, so leaves the value.
       
       if (c == 'A'){
         //integerValZ = val;
         integerValZ = Integer.parseInt(val2.trim()); //THIS IS FOR CREATING THE RIGHT integer OUT OF THE string       
         println(integerValZ);
       }
       
       if (c == 'B'){
         //integerValY = val;
         integerValY = Integer.parseInt(val2.trim()); //THIS IS FOR CREATING THE RIGHT integer OUT OF THE string
         println(integerValY);
       }
       
      if (c == 'C'){
         //integerValX = val;
         integerValX = Integer.parseInt(val2.trim()); //THIS IS FOR CREATING THE RIGHT integer OUT OF THE string
         println(integerValX);
       }
       
      if (c == 'D'){
         //integerValW = val;
         integerValW = Integer.parseInt(val2.trim()); //THIS IS FOR CREATING THE RIGHT integer OUT OF THE string
         println(integerValW);
       }       
    } 
  }
  
  

  // this line will start pdf export, if the variable savePDF was set to true 
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER); 
  noStroke();
  
  
  background(integerValZ, 100, 100);

  fill(360-integerValW, 100, 100);
  rect(360, 360, integerValX+1, integerValY+1);
  
  // end of pdf recording
  if (savePDF) {
    savePDF = false;
    endRecord();
  }



}



String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}