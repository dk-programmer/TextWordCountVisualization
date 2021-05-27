public class Comperator{
ArrayList<Tupel> list1 = new ArrayList<Tupel>();
ArrayList<Tupel> list2 = new ArrayList<Tupel>();


public void AddStringToList(String value,int tupelNR ,int list){
  if(list == 1){
    AddToTupelList(value,tupelNR,list1);
  }else if(list == 2){
    AddToTupelList(value,tupelNR,list2);
  }
}

public void CompareString(String value,int list){
  if(list == 1){
    for(int i = 0; i < list1.size(); i++){
      list1.get(i).Compare(value);
    }    
  }
  if(list == 2){
    for(int i = 0; i < list2.size(); i++){
      list2.get(i).Compare(value);
    }    
  }

  return;
}

public void AddToTupelList(String value,int tupelNR,ArrayList<Tupel> list){
  if(list.size() >= tupelNR){
    list.get(tupelNR-1).comperator.add(value);
  }else{
    list.add(new Tupel(value));
  }
}
public void resetScore(){
  for(int i = 0; i < list1.size(); i++){
    list1.get(i).score = 0;
  }    
  for(int i = 0; i < list2.size(); i++){
    list2.get(i).score = 0;
  }  
}

class Tupel{
  ArrayList<String> comperator = new ArrayList<String>();
  int score = 0;
  public Tupel(String value){
    comperator.add(value);
  }
  public String toString(){
    String temp = "";
    for(int i = 0; i < comperator.size(); i++){
      temp += comperator.get(i) + ",";
    }
    return temp + " " + score;
  }
  public void Compare(String value){
    println("compare "+value);
    for(int i = 0; i < comperator.size();i++){
      if(comperator.get(i).equals(value)){
        score ++;
      }
    }
  }
}
}
