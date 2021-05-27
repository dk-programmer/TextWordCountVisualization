import shiffman.box2d.*;
import static java.nio.charset.StandardCharsets.*;
import controlP5.*;

ControlP5 cp5;
float w = 1500;
float h = 1000;
float xPerChar = 12;
int tabSize = 40;
int offsetText = 280;
Comperator comp;
Vector2 translator = new Vector2(0,0);
Vector2 stepCounter1 = new Vector2(0,0);
Vector2 stepCounter2 = new Vector2(0,0);
int stepper = 20;
int timer = 0;
boolean isRun = false;
String fulltxt1 = "Er geht zum Bahnhof. Hat sie hunger?";
String fulltxt2 = "Kare ha eki ni ikimasu. Honda san ha  onaka ga sukimasu ka.";
String text1[] = {"Dies ist ein Text der nicht so lange ist ende", "dieser test ist nicht so lange ende","ende", "dieser test ist nicht so lange ende"};
String text2[] = {"test","Dies ist ein Text der nicht so lange ist", "dieser test ist auch nicht so lange ende"};

ClipHelper cp = new ClipHelper();




void setup() {
  size(1500, 1000);
  PFont font;
  text1 = processInputText(fulltxt1);
  text2 = processInputText(fulltxt2);
  font = loadFont("font.vlw");
  textFont(font, 40);
  PFont pfont = createFont("Arial",30,true);
  cp5 = new ControlP5(this);

  cp5.addTextfield("Comperator_Left").setPosition(0, tabSize).setSize((int)w/2, tabSize).setAutoClear(true).setFont(pfont).setColorBackground(color(150));
  cp5.addTextfield("Comperator_Right").setPosition(w/2, tabSize).setSize((int)w/2, tabSize).setAutoClear(true).setFont(pfont).setColorBackground(color(150));
  cp5.addTextfield("TupelNRLeft").setPosition(0+w/4, tabSize + tabSize*2).setSize((int)w/4, tabSize).setAutoClear(true).setFont(pfont).setColorBackground(color(150));
  cp5.addTextfield("TupelNRRight").setPosition(w/2 + w/4, tabSize + tabSize*2).setSize((int)w/4, tabSize).setAutoClear(true).setFont(pfont).setColorBackground(color(150));
  cp5.addBang("AddLeft").setPosition(0, tabSize + tabSize*2).setSize((int)w/4, tabSize);   
  cp5.addBang("AddRight").setPosition(w/2, tabSize + tabSize*2).setSize((int)w/4, tabSize); 
  cp5.addBang("StartRunText").setPosition(w/2 - (int)w/3 /2 , tabSize + tabSize*3).setSize((int)w/3, tabSize).setColorForeground(color(0,155,0));  
  cp5.addBang("AddText1").setPosition(0 , tabSize + tabSize*3).setSize((int)w/3, tabSize);
  cp5.addBang("AddText2").setPosition(w/3 * 2, tabSize + tabSize*3).setSize((int)w/3, tabSize);
  
  
  comp= new Comperator();
  cp5.setAutoDraw(false);
}
public String[] processInputText(String text){
  String[] splitText = split(text,' ');
  float spacePerLine = w/3/xPerChar;
  String returnString = "<br> ";
  int countedChars = 0;
  for(int i = 0; i < splitText.length; i++){
    countedChars += splitText[i].length() +1;
    if(countedChars <= spacePerLine){
      returnString += splitText[i] + " ";
    }else{
      returnString = returnString.substring(0, returnString.length() - 1);
      returnString += "<br>";
      returnString += splitText[i] + " ";
      countedChars = splitText[i].length() +1;
    }
  }
  return split(returnString, "<br>");
}
public void RunTextIncrementation(){
  boolean isFinished1 = false,isFinished2 = false;
  stepCounter1.x++;
  stepCounter2.x++;
  if(!(stepCounter1.y < text1.length))isFinished1 = true;
  if(!(stepCounter2.y < text2.length))isFinished2 = true;
  if((isFinished1 || stepCounter1.x >= split(text1[stepCounter1.y],' ').length) && (isFinished2 || stepCounter2.x >= split(text2[stepCounter2.y],' ').length)){
    stepCounter1.x = 0; stepCounter1.y++;
    stepCounter2.x = 0; stepCounter2.y++;
  }
  if(!(stepCounter1.y < text1.length))isFinished1 = true;
  if(!(stepCounter2.y < text2.length))isFinished2 = true;
  if(!isFinished1 && stepCounter1.x < split(text1[stepCounter1.y],' ').length){
    comp.CompareString(cleanString(split(text1[stepCounter1.y],' ')[stepCounter1.x]),1); 
  }
  if(!isFinished2 && stepCounter2.x < split(text2[stepCounter2.y],' ').length){
    comp.CompareString(cleanString(split(text2[stepCounter2.y],' ')[stepCounter2.x]),2); 
  }
  if(isFinished1 && isFinished2){
    isRun = false;
    return;
  }
  if((!isFinished1 && !(stepCounter1.x < split(text1[stepCounter1.y],' ').length))){
    stepCounter1.x = split(text1[stepCounter1.y],' ').length -1 ;
  }
  if((!isFinished2 && !(stepCounter2.x < split(text2[stepCounter2.y],' ').length))){
    stepCounter2.x = split(text2[stepCounter2.y],' ').length -1 ;
  }
  if(isFinished1){
    stepCounter1.x = 0;
    stepCounter1.y = text1.length;
  }
  if(isFinished2){
    stepCounter2.x = 0;
    stepCounter2.y = text2.length;
  }
}
 
void draw () {
  stroke(204, 102, 0);
  strokeWeight(0); 
  translate(translator.x,translator.y);
  timer++;
  if(timer%stepper == 0 && isRun){
    RunTextIncrementation();
  }
  int BGC = 230;
  int TEXTC = 0;
  
  background(255);
  fill(220);
  rect(0,0,w,4*tabSize);
  cp5.draw();
  rect(0,2*tabSize,w,tabSize);
  textSize(32);
  fill(0);
  textAlign(CENTER);
  text("Suchwort Links", w/4, tabSize / 2 + 16); 
  text("Suchwort Rechts",3* w/4, tabSize / 2 + 16); 
  text("Nr Links", 3*w/8, 2* tabSize + tabSize / 2 + 16);
  text("Nr rechts", 7*w/8, 2* tabSize + tabSize / 2 + 16);
   fill(240); 
  text("Bestätigen Rechts", 5*w/8,  4* tabSize - 10);
  text("Bestätigen Links", w/8, 4* tabSize - 10); 
  text("Start", w/2, 5* tabSize - 10);
  text("Paste Text 1", w/3/2, 5* tabSize - 10);
  text("Paste Text 2", w/3/2+w/3 * 2, 5* tabSize - 10);
  fill(240);
  stroke(204, 102, 0);
  strokeWeight(4);  
  rect(0,offsetText-tabSize,w/3,text1.length*tabSize+ tabSize);
  rect(w/3*2,offsetText - tabSize,w,text2.length*tabSize +tabSize);
 
  drawPosition();
  for(int i = 0; i < text1.length ; i++){
    textSize(20);
    fill(TEXTC);
    textAlign(LEFT);
    text(text1[i], 0,offsetText + tabSize*i); 
  }
  for(int i = 0; i < text2.length ; i++){
    textSize(20);
    fill(TEXTC);
    textAlign(RIGHT);
    text(text2[i], w, offsetText + tabSize*i); 
  }
    for(int i = 0; i < comp.list1.size(); i++){
    if(i < comp.list2.size()){
      fill(230);
      stroke(0, 0, 0);
      strokeWeight(1); 
      rect(w/3,offsetText - 20 + 2*tabSize*i,w/3,tabSize * 1.5);
    }
  }
  for(int i = 0; i < comp.list1.size(); i++){
    String t1 = comp.list1.get(i).toString();
    textSize(20);
    fill(TEXTC);
    textAlign(LEFT);
    text(t1, w/3 + 10, offsetText + 2*tabSize*i); 
  }
  for(int i = 0; i < comp.list2.size(); i++){
    String t1 = comp.list2.get(i).toString();
    textSize(20);
    fill(TEXTC);
    textAlign(RIGHT);
    text(t1, 2*w/3 - 10, offsetText + 2*tabSize*i); 
  }
  for(int i = 0; i < comp.list1.size(); i++){
    if(i < comp.list2.size()){
      calculateRect(new Vector2((int)w/3,offsetText + 20 + 2*tabSize*i ) , comp.list1.get(i).score , comp.list2.get(i).score);
    }
  }
  textAlign(LEFT);
}
 
void AddLeft() {
  String value = cp5.get(Textfield.class,"Comperator_Left").getText();
  int TupelNr = Integer.parseInt(cp5.get(Textfield.class,"TupelNRLeft").getText());
  comp.AddStringToList(value,TupelNr,1);
  println("Add :"+value + "|" + TupelNr);
}
void AddRight() {
  String value = cp5.get(Textfield.class,"Comperator_Right").getText();
  int TupelNr = Integer.parseInt(cp5.get(Textfield.class,"TupelNRRight").getText());
  comp.AddStringToList(value,TupelNr,2);
    println("Add :"+value + "|" + TupelNr);
}

void StartRunText() {
  isRun = true;
  Reset();
}
void calculateRect(Vector2 pos,int Value1,int Value2){
  float MaxSize = w/3;
   if(Value1 <= 0 && Value2 <= 0) {Value1 = 1; Value2 = 1;} 
  float MaxValue = Value1 + Value2;
  float size1 = Value1 / MaxValue * MaxSize;
  float size2 = Value2 / MaxValue * MaxSize;
  fill(50,15,200);
  rect(pos.x, pos.y, size1, 20, 5);
  fill(0,200,40);
  rect(pos.x + size1, pos.y, size2, 20, 5);
}
public String cleanString(String s){
  s = s.toLowerCase();
  s = s.replaceAll("[^\\w\\s]","");
  return s;
}
public void drawPosition(){
  fill(0,255,0);
  
  if(stepCounter1.y < text1.length){
    ellipse(calculateDrawPosition(text1[stepCounter1.y],stepCounter1.x),-30 + offsetText + stepCounter1.y * tabSize, 20, 20);
  }
  if(stepCounter2.y < text2.length){
    ellipse(w + calculateDrawPosition(text2[stepCounter2.y],stepCounter2.x) - (text2[stepCounter2.y].length() * xPerChar),-30 + offsetText + stepCounter2.y * tabSize, 20, 20);
  }
}
public float calculateDrawPosition(String fullLine,int step){

  String[] splitFullLine = split(fullLine,' ');
  String comperatorString = "";
  for(int i = 0; i < step; i++){
    comperatorString += splitFullLine[i];
  }
  float x = (comperatorString.length() + step + splitFullLine[step].length()/2) * xPerChar;
  return x;
}
public void Reset(){
  stepCounter1 = new Vector2(0,0);
  stepCounter2 = new Vector2(0,0); 
  comp.resetScore();
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      translator.y += 15;
      if(translator.y > 0){
        translator.y = 0;
      }
    } else if (keyCode == DOWN) {
      translator.y -= 15;
    } 
  }
}
public void AddText1(){
    fulltxt1 = cp.pasteString();
    text1 = processInputText(fulltxt1);
}
public void AddText2(){
    fulltxt2 = cp.pasteString();
    text2 = processInputText(fulltxt2);
}

class Vector2{
  int x;
  int y;
  public Vector2(int X, int Y){
    x = X;
    y = Y;
  }
}