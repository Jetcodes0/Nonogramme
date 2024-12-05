class Grille {
  Case tab1[][];
  int [][] tab;
  String [] suite;
  String N;
  int col, lig;
  int nbcolor;
  int[][]tabcolor;
  int posx=650;
  int posy=250;
  int x,y;


  int[] legende_lig ;
  int [] legende_col ;
  String SuiteLigne = "" ;
  String SuiteColonne  = "";
  String idcouleur_lig = "" ;
  String idcouleur_col  = "";
  int[] legendecouleur_lig ;
  int [] legendecouleur_col ;

void ChargerTableaux(String Fichier) {
  String[] ChargerTab = loadStrings(Fichier);
  String[]elem;
  String[] taille;
  String[]elemcolor;

  //println(ChargerTab[0]);

  N = ChargerTab[0];
  taille = splitTokens(N, " ");
  //printArray(taille);

  lig = int(taille[1])+1;
  col = int(taille[0]);
  
  tab = new int [lig][col];
  for (int i= 1; i<lig; i++) {
    elem = splitTokens(ChargerTab[i], " ");

    for (int j=0; j<col; j++) {
      tab[i][j] = int(elem[j]); //<>//
    }
  }
  nbcolor=int(ChargerTab[lig]);
  //println(nbcolor);
  tabcolor=new int[nbcolor][4];  
  for (int i= 0; i<nbcolor; i++) {
    elemcolor = splitTokens(ChargerTab[lig+1+i], " ");

    for (int j=1; j<4; j++) {
      tabcolor[i][j] = int(elemcolor[j]);
    }
    //printArray(elemcolor);
  }
  
}

void affichecolor(){
  for (int i= 0; i<nbcolor; i++) {
    println();
    for (int j=1; j<4; j++) {
      print(tabcolor[i][j]);
    }
  }
}

void afficherConsol() {
  for (int i= 1; i<lig; i++) {

    println();
    for (int j=0; j<col; j++) {

      print(tab[i][j]);
    }
  }
}

 void dessin() {
    image(backgroundImgbis, 0, 0, width, height);
    for (int i=1; i<lig; i++)
      for (int j=0; j<col; j++) {
        tab1[i][j].dessin(tabcolor,nbcolor);  
      }
  }


void initGrille() {
  tab1=new Case[lig][col];
  for (int i=0; i<lig; i++) {
    for (int j=0; j<col; j++) {
      tab1[i][j]=new Case();
      tab1[i][j].initCase(i, j);
    }
  }
}

boolean verif_fin(){
  int cmpt1=0;
  int cmpt2=0;
  for(int i=0;i<tab1.length;i++){
    for(int j=0;j<tab1[i].length;j++){
      if(tab[i][j]==1) cmpt1++;
    }
  }
  for(int i=0;i<tab.length;i++){
    for(int j=0;j<tab[i].length;j++){
      if(tab1[i][j].id==1) cmpt2++;
    }
  }
    for(int i=0;i<tab1.length;i++){
    for(int j=0;j<tab1[i].length;j++){
      if(tab[i][j]!=tab1[i][j].id) return false;
    }
  }
  if(cmpt1==cmpt2){
    g.initGrille();
    textSize(128);
    fill(255, 000, 000);
    text("REUSSI", 400, 400); 
    
    jeuSelected=false;
    play=false;
    return true;
    
  }
  return false;
}

void palette_color(){
  for (int i= 0; i<nbcolor; i++) {
    if(i%2==1) posx=725;
    if(i%2==0){
      posx=650;
      posy+=75;
    }
    fill(tabcolor[i][1],tabcolor[i][2],tabcolor[i][3]);
    rect(posx,posy,50,50);
  }
  posy=250;
}


  void compt_lig () {
    int cpt =0;
    int indice=-5;
    for (int i= 1; i<lig; i++) {
      for (int j=0; j<col; j++) {
        if (tab[i][j] >= 1) {
          if(cpt==0){
           cpt=1;
           indice=tab[i][j];
          }else if(cpt>0&& indice==tab[i][j] ){
            cpt++;
          }else if(cpt>0&& indice!=tab[i][j]){
           SuiteLigne= SuiteLigne+ str(cpt )+",";
           idcouleur_lig +=str(indice)+",";
          cpt =1; 
          indice=tab[i][j];
          }  
        }
        if (tab[i][j] ==0 && cpt >0 || (j==col-1 && cpt >0 )) {
          SuiteLigne= SuiteLigne+ str(cpt )+",";
          idcouleur_lig +=str(indice)+",";
          cpt =0;
          indice=-5;
        }
      }
      SuiteLigne =SuiteLigne + " ; ";
      idcouleur_lig+=" ; ";
      cpt=0;
      indice=-5;
    }
  }

  void compt_col () {
    int cpt =0;
    int indice=-5;
    for (int j= 0; j<col; j++) {
      for (int i=0; i<lig; i++) {
        if (tab[i][j] >= 1) {
          if(cpt==0){
           cpt=1;
           indice=tab[i][j];
          }else if(cpt>0&& indice==tab[i][j] ){
            cpt++;
          }else if(cpt>0&& indice!=tab[i][j]){
           SuiteColonne= SuiteColonne+ str(cpt )+",";
           idcouleur_col +=str(indice)+",";
          cpt =1; 
          indice=tab[i][j];
          }
        }
        if (tab[i][j] ==0 && cpt >0 || (i==lig-1 && cpt >0 )) {
          SuiteColonne= SuiteColonne+ str(cpt )+",";
          idcouleur_col +=str(indice)+",";
          cpt =0;
          indice=-5;
        }
      }
      SuiteColonne =SuiteColonne + " ; ";
      idcouleur_col+=" ; ";
      cpt=0;
      indice=-5;
    }
  }

  void init_legende(int x,int y) {
    int niv =x;
      for (int i=0; i< lig; i++) {
        legende_lig = int(splitTokens(SuiteLigne, " ,"));
      }
      for (int i=0; i< lig; i++) {
        legendecouleur_lig = int(splitTokens(idcouleur_lig, " ,"));
      }
    for (int i =legende_lig.length-1; i>-1; i--) {
    if (legende_lig[i] == 0) {
      y=y-TAILLECASE;
      x=niv;  
    }
    else  {
      
      fill(tabcolor[legendecouleur_lig[i]][1],tabcolor[legendecouleur_lig[i]][2],tabcolor[legendecouleur_lig[i]][3]);
      rect(x-9,y-36,20,TAILLECASE,24,24,24,24);
      fill(255);
      text(g.legende_lig[i], x, y);
       x=x-24;
    
    }
  }
  }
  
    void init_legende_vertical(int x,int y) {
      int niv =y;


    for (int i=0; i< col; i++) {
      legende_col = int(splitTokens(SuiteColonne, " ,"));
    }
    for (int i=0; i< lig; i++) {
        legendecouleur_col = int(splitTokens(idcouleur_col, " ,"));
    }
   for (int i =legende_col.length-1 ; i>-1; i--) {
    if (legende_col[i] == 0) {
      y=niv;
     x=x-TAILLECASE;     
    }
    else  {
      fill(tabcolor[legendecouleur_col[i]][1],tabcolor[legendecouleur_col[i]][2],tabcolor[legendecouleur_col[i]][3]);
      rect(x-30,y-10,TAILLECASE,20,24,24,24,24);
      fill(255);
      text(legende_col[i], x, y);
     y=y-24;
    }
  }
  }
   
}
