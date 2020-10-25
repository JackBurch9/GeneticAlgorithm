// Created by Jack Burch
// The aim of this program is to use the techniques of genetic algorithms to create aerodynamic 2D shapes.

boolean isDone = false; // a check to see if setup functions have been run
Creature creature; // used for intitating the creature class 
Creature[] storage = new Creature[21]; // will be used to store creatures
float[] fitnesses = new float[21]; // stores the fitness of the creatures
int neededWidth = 25; // how wide the creature needs to be to survive
float fitnessTotal; // the total fitness of the creatures 
boolean setUp = true; // works with isDone to do setup in the creature class
boolean isFirstGeneration = true; // tells if it is the first generation of creatures
int timer = 0;
boolean isPaused = true;
void setup() {
  size(1000, 700);
  background(255);
  //this for loop creates the initial creatures
  for(int i = 0; i < 21; i++){
      creature = new Creature(15);  // creates creatures and creates 15 spots for genes
      creature.geneCreator(); // creates genes for the creatures
      storage[i] = creature; // stores the creatures for display and manipulation
  }
    setUp = false; // finishes creature set up
    creature.drawCreature(); // starts displaying the creatures
}
void draw(){
  frameRate(100);
  timer++; // ticks the timer forward, this controls when the pace of the project
  background(255); 
  stroke(255,0,0);
  fill(103);
  line(0,height/2, width, height/2);
  stroke(0);
  // generates the total fitness by adding all the fitnesses together
  fitnessTotal = fitnesses[0] +
            fitnesses[1] + fitnesses[2] + fitnesses[3] +
            fitnesses[4] + fitnesses[5] + fitnesses[6] +
            fitnesses[7] + fitnesses[8] + fitnesses[9] + 
            fitnesses[10] + fitnesses[11] + fitnesses[12] + 
            fitnesses[13] + fitnesses[14] + fitnesses[1] +
            fitnesses[15] + fitnesses[16] + fitnesses[17] +
            fitnesses[18] + fitnesses[19];          
            
  
 
  
  
  HUD(creature); // displays the information in the program
  creature.drawCreature(); // displays the current creature
  creature.calcFit(); // calculates the fitness of the creature
  
 }
 // this is all just UI things and displaying information
 void HUD(Creature creature){
   textSize(20);
   fill(0);
   text("Creature: "  + creature.getCreatureCounter(), 10 , 20); // what creature is being displayed
   text("Generation: "  + creature.getGenerationCounter(), 10 , 40); // what generation we are on
   text("Mutations: "  + creature.getMutationNumber(), 10 , 60); // how many mutations have happened
   if(fitnesses[creature.getCreatureCounter()  - 1] != 0){
     text("Fitness: "  + fitnesses[creature.getCreatureCounter()  - 1], 10 , 80); // what is the fitness of the displayed creature
     } else {
       text("Fitness: "  + "Dead", 10 , 80); // if it doesn't meet the width requirement it "dies"
     }
    
   text("Needed Width: "  + neededWidth + "  (Press w to increase, a to decrease)", 10 , 100); // shows the required width for the creatures
   text("Press p to start/stop the program", 10 , height - 20); // UI to tell how to pause
   
   // displays all the fitnesses of the creatures
   for(int i = 0; i < 20; i++){
       textSize(12);
       if(fitnesses[i] != 0){
       text("Fitness "+ (i + 1) + ": "  + (fitnesses[i]),850 ,15 + (i*15));
       } else {
       text("Fitness "+ (i + 1) + ": "  + "Dead",850,15 + (i*15));
       }
       
      // if none of the creatures are fit for passing on thier genes, it displays the message below and ends the program
       if(fitnessTotal == 0 && isDone == true){
      background(255);
      isPaused = true; 
       text("All of the creatures have gone extinct, this is usually caused from either:", 10 , 20); 
       text("- random variance at the beginning of the program creating no viable creatures", 10 , 40); 
       text("- changing the needed width of the creatures more quickly than they can adapt.", 10 , 60); 
       text("Please restart the program", 10 , 80); 
       
    } 
   }
   
   if(timer >= 10 && isPaused == false){
     timer = 0;
     creature.storeCreature();
     creature.geneCreator();
   }
 }
 //changes the required width and pauses/unpauses
 void keyPressed(){
     if(key == 'p' && isPaused == false){
       isPaused = true;
     } else if (key == 'p' && isPaused == true){
       isPaused = false;
     }
     if(key == 'w' ){
       neededWidth = neededWidth + 1;
     }
     if(key == 's' ){
       neededWidth = neededWidth - 1;
     }
   
   }
 
 
 
    
  
 
