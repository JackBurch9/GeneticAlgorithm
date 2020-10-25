class Creature {
   PVector v; // is used to create the velecoties of the line segments (velocty is converted to the oriantation of the line segments)
   private int arrayLength; // how long the genes array is 
   private PVector[] genes;  // array for storing the genes of the creature
   private int r = Math.round(random(50,255));  // these three colors are just to make the creatures look a little prettier
   private int g = Math.round(random(50,255));
   private int b = Math.round(random(50,255));
   int creatureCounter = 1; // what creature the computer looks at first 
   int generationCounter = 1; // what generation it is
   int mutationNumber = 0; // how many mutations have happened
   float fitness; // how fit an individual creature is
   PVector[] child = new PVector[15]; // will be used for passing on genes between generations
   float[] sortedFitnesses = new float[fitnesses.length]; // an array of the fitnesses of all the creatures sorted from most fit to least
   PVector[] test1 = new PVector[21];
   // creates creatures with a number of genes and line segments equal to the number given
      public Creature (int length) {
     arrayLength = length;
     genes = new PVector[arrayLength];
   }
   // creates the initial genes of the creatures randomly
   void geneCreator(){
     if(setUp == true){
       for (int i = 0; i < arrayLength; i++) {
         v = PVector.random2D();
         // makes sure the line segments dont fold in on themselves
         if(v.x <= 0){ 
           v.x = v.x * -1;
         }
         if(v.y >= 0){
           v.y = v.y; 
         }
         // addes the genes to genes array
         genes[i] = v;
       }
     }else {
         for (int i = 0; i < arrayLength; i++) {
             genes[i] = storage[creatureCounter - 1].genes[i];
         }
       }
     }
 
 
   // this simulates the mutation of genes between generations, allows for the improvement of the creatures
     public void mutation(float m){
       for (int j = 0; j < genes.length; j++){
          for (int i = 0; i < genes.length; i++) {
            if (random(1) < m) {
              mutationNumber++;   
              PVector gee = PVector.random2D(); // this is a temp gene that is used to replace other genes at random
                  if(gee.x <= 0){
                     gee.x = gee.x * -1;
                    }
                     if(gee.y >= 0){
                       gee.y = gee.y; 
                      }
                  storage[j].genes[i] = gee; // replaces the genes of the creature with the mutation
                
            }
          }
       }
        }
        
        PVector starts; 
        PVector ends;
      public void drawCreature(){
            // converts the genes into line segments and displays them
             
            translate(0,height/2);
            for (int i = 0; i < arrayLength; i++) {
               PVector start = new PVector(0,0);
               PVector end = new PVector(0,0);
               for (int c = i -1 ; c >= 0; c--) {
                   start.add(genes[c]);
               }
               // the next 15 or so lines of code draw the line based off of the gene and then add the value of the line to the next line
               // this is so each line starts where the last line ended
               end.set(start);
               test1[i] = start;
               end.add(genes[i]);
               starts = start;
               ends = end;
               stroke(r,g,b); // for fun
               strokeWeight(1.75);
               line(start.x * 50, start.y * 50, end.x * 50, end.y * 50);
               stroke(b,g,r); // for fun
               line(start.x * 50, start.y * -50, end.x * 50, end.y * -50);
               strokeWeight(1);
               // this if statement creates the red line at the end of the creature
               if(i + 1 == arrayLength){
                  stroke(255,0,0);
                  line(end.x * 50,0 - height/2,end.x * 50,height);
                  fitnesses[creatureCounter - 1] = end.x;
                  stroke(0);
               }
            } 
          } 
          // this calculates the fitness of the creature, which is used to determine who lives and who dies 
          // initailly I wanted fitness to be based off of how aerodynamic the creature was but due to time constrants tthe calculations just see how long it is 
          // this gives similar results to most aerodynamic without the complex math
       public void calcFit(){ 
         float h = 0;
         for(int i = 0; i < 15; i++){
             h = h + test1[i].y;
         }
         if (h < neededWidth){
             fitnesses[creatureCounter - 1] = 0; // if is not wide enough its fitness becomes 0
         }else {
             fitnesses[creatureCounter - 1] = ends.x;
         }
       }
       // tick through the creatures and moves onto the next generation when it's finished
       public void storeCreature(){
       if (creatureCounter < 20){
          creatureCounter++;
        }else {
          creatureCounter = 1;
          generationCounter++;
          creature.evolution();
          creature.matingPoolGeneration();
          isFirstGeneration = false;
        }
      }
      // turns the best genes from the previous generation into the new generation
      public void evolution(){
          int crossover = 6;
          if(7 > crossover){
          for (int i = 0; i < genes.length; i++) {
              child[i] = storage[creature.matingPoolGeneration()].getGene(i);
            }
          }
            for (int j = 0; j < 20; j++) {
              for (int i = 0; i < genes.length; i++) {
                storage[j].genes[i] = child[i];
              }
            }
            println();
           // if setup is done it starts mutation
            if (isDone != true){
            creature.mutation(.05);  // the value is the frequency of mutation
            }
            
      }
      // uses the stored sorted fitness array in order to return the best fitness 
      public int matingPoolGeneration(){
        arrayCopy(fitnesses,sortedFitnesses);
        sortedFitnesses = sort(sortedFitnesses);
        
         for (int i = 0; i < storage.length; i++){
           if(fitnesses[i] == sortedFitnesses[20]){
             
             if(fitnessTotal == 0 || fitnesses[i] >= 15){
                isDone = true;
      
                  }else {
                  isDone = false;
                  
                }
             return i;
             
             
           }
        }
        return 1;
         
        
          
          
      }
        
      
      // below this is all just minor get/set functions for information display and use
      
      // the starts of the line segments
      PVector getStart(){
        return starts;
      }
      // end of the line segments
      public PVector getEnd(){
        return ends;
      }
      // gets a specific gene
      public PVector getGene(int a){
          return(genes[a]);
      }
      //sets a specific gene
      public void setGene(int c,int i,PVector a){
          storage[c].genes[i] = a;
      }
     // gets gene length
      public int getGeneLength(){
        return genes.length;
      }
      // returns which creature is being displayed
      int getCreatureCounter(){
        return creatureCounter;
      }
      // returns what generation of creatures is currently being displayed
      int getGenerationCounter(){
        return generationCounter;
      }
      // returns if it is the first generation of creatures
      boolean isFirstGeneration(){
        return isFirstGeneration;
      }
      // returns how many mutations have happened (mutations being changes in genes)
      int getMutationNumber(){
        return mutationNumber;
      }
     // returns the fitness of the current creature 
      float getFitness(){
      return fitness;
      }
      
 }
