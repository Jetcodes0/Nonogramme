PImage backgroundImg;
PImage backgroundImgjeu;
PImage backgroundImgbis;
PImage menu;
Grille g;
Grille geditor;
PImage buttonImageJeu;
PImage VictoireImg;
PImage buttonImageEditeur;
final int TAILLECASE = 64;
int largeurBouton = 200;
int hauteurBouton = 80;
int buttonX, buttonY;
Case c1;
boolean jeuSelected = false;
boolean editeurSelected = false;
boolean play = false;

int replay = 0;
int cols;
int rows;
int display = 0 ;
int[][] puzzle;
String[] nbfichiers;
int indiceAleatoire;
String fichierChoisi;

int colorpinceau = 0;

boolean launchE = false;
int cpt = 0;
int cpt25 = 0 ;


int compterL;
int Sup0 = 0;
int[] tab_nbelemL = new int[31];
int[] nb_elemL;
PFont font;

String folderPath="images";

int startTime;
int elapsedTime;
boolean timerStarted = false;
boolean overButtonMenu; 
void setup() {


  fill(0, 0, 0);
  backgroundImg = loadImage("fonds/Picross-e8.png");
   backgroundImgbis = loadImage("fonds/Picross-e8bois.png");
  VictoireImg  = loadImage("fonds/victoire.jpg");
  backgroundImgjeu = loadImage("fonds/PicrossJeu.png");// Remplacez "background_image.jpg" par le nom de votre image de fond
  buttonImageJeu = loadImage("fonds/button_image.png");
  buttonImageEditeur = loadImage("fonds/button_image2.png");
  menu = loadImage("fonds/menu.png");
  buttonX = width / 2 - largeurBouton / 2;
  buttonY = height / 2 - hauteurBouton;
  c1 = new Case();

  g = new Grille();
  String cheminDuRepertoire = sketchPath("images");
  File dossier = new File(cheminDuRepertoire);
  nbfichiers = dossier.list();
  indiceAleatoire = int(random(nbfichiers.length));
  fichierChoisi = nbfichiers[indiceAleatoire];
  println("Fichier choisi au hasard :" + fichierChoisi);
  g.ChargerTableaux("images/"+fichierChoisi);
  g.initGrille();
  //g.afficherConsol();
  //g.affichecolor();

  textFont(loadFont("font.vlw"), 20);

  // Bouton "Jeu"
  createButton("Jeu", buttonX, buttonY, buttonImageJeu);

  // Bouton "Éditeur"
  createButton("Éditeur", buttonX, buttonY + hauteurBouton, buttonImageEditeur);

  g.compt_lig ();
  g.compt_col ();


  font = loadFont("font.vlw");
  textFont(font, 20);
  size(1000, 1000);
}


void createButton(String label, float x, float y, PImage image) {
  fill(200);
  rect(x, y, largeurBouton, hauteurBouton);

  // Dessiner l'image comme fond du bouton
  image(backgroundImg, x, y, largeurBouton, hauteurBouton);

  // Dessiner l'image du bouton
  image(image, x, y, largeurBouton, hauteurBouton);

  textAlign(CENTER, CENTER);
  textSize(16);
  fill(0);
  text(label, x + largeurBouton / 2, y + hauteurBouton / 2);
}

void draw() {
  textSize(16);

  image(backgroundImg, 0, 0, width, height);

  boolean overButtonJeu = isMouseOverButton(mouseX, mouseY, buttonX, buttonY);
  boolean overButtonEditeur = isMouseOverButton(mouseX, mouseY, buttonX, buttonY + hauteurBouton);
  overButtonMenu = isMouseOverButton(mouseX, mouseY, buttonX+300, buttonY+300 );

  if (overButtonJeu || jeuSelected) {
    tint(200); 
  }
  image(buttonImageJeu, buttonX, buttonY, largeurBouton, hauteurBouton);
  noTint(); 

  if (overButtonEditeur || editeurSelected) {
    tint(200); 
  }
  image(buttonImageEditeur, buttonX, buttonY + hauteurBouton, largeurBouton, hauteurBouton);
  noTint(); 



  if (jeuSelected) {

    elapsedTime = (millis() - startTime) / 1000;
    g.dessin();
    fill(255);
    textSize(36);
    println("Temps total: " + nf(elapsedTime, 2) + " secondes");
    text("Temps écoulé: " + nf(elapsedTime, 2), 780, 280);
    textSize(16);
    g.palette_color();
    g.init_legende_vertical(TAILLECASE * g.col + 130, 140);
    g.init_legende(75, TAILLECASE * g.lig+135);
    if (g.verif_fin()) {
      println("reussi");
          jeuSelected=false;     
    play=false;
    editeurSelected=false;
    }
  } else if (editeurSelected ) {
    display = 1;
    image(backgroundImgjeu, 0, 0, width, height);
    if (display == 1 && cpt<1) {
      cols = Clavier.lireEntier("Nombre de colonnes ( max 8 )");
      rows = Clavier.lireEntier("Nombre de lignes (max 12 )");
      while( cols > 8 || rows >12 ){
      cols = Clavier.lireEntier("Nombre de colonnes ( max 8 )");
      rows = Clavier.lireEntier("Nombre de lignes (max 12 )");
        
      }
      puzzle = new int[rows][cols];
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          puzzle[i][j] = 0;
        }
      }

      cpt ++ ;
    }
    displayPuzzle();
    if (overButtonMenu) {
    tint(200); 
  }
  image(menu, buttonX+300, buttonY+300, largeurBouton, hauteurBouton);
  }
}

boolean isMouseOverButton(int x, int y, int buttonX, int buttonY) {
  return x > buttonX && x < buttonX + largeurBouton && y > buttonY && y < buttonY + hauteurBouton;
}

void mousePressed() {
  println("x : " +mouseX);
  println("y : " +mouseY);
  if (display == 0) {
    if (isMouseOverButton(mouseX, mouseY, buttonX, buttonY)) {

      if (!editeurSelected) {
        jeuSelected = true;
        editeurSelected = false;
        startTime = millis();

      }
      if (jeuSelected && g.verif_fin()) {
        jeuSelected = false;
        editeurSelected = false;
        buttonX = width / 2 - largeurBouton / 2;
        buttonY = height / 2 - hauteurBouton;
        cpt25 = 0; 
      }
    } else if (isMouseOverButton(mouseX, mouseY, buttonX, buttonY + hauteurBouton)) {

      if (!jeuSelected) {
        jeuSelected = false;
        editeurSelected = true;
        //println("Bouton Éditeur cliqué !");
        display = 1;
      }
    }
    if (display == 1) {
      int col = mouseX / TAILLECASE;
      int row = mouseY / TAILLECASE;
      if (col >= 0 && col < cols && row >= 0 && row < rows) {
        puzzle[row][col] = colorpinceau; 
      }
    }
    if (jeuSelected) {
      int col = (mouseX - 100) / TAILLECASE;
      int lig = (mouseY - 100) / TAILLECASE;
      if (play) {
        timerStarted = false;
        if (dist(mouseX, mouseY, 675, 350)<=30)
          colorpinceau=0;
        else if (dist(mouseX, mouseY, 750, 350)<=30)
          colorpinceau=1;
        else if (dist(mouseX, mouseY, 675, 425)<=30)
          colorpinceau=2;
        else if (dist(mouseX, mouseY, 750, 425)<=30)
          colorpinceau=3;
        else if (dist(mouseX, mouseY, 675, 500)<=30)
          colorpinceau=4;
        else if (dist(mouseX, mouseY, 750, 500)<=30)
          colorpinceau=5;

        if (lig < g.lig && col < g.col &&lig>=0 && col>=0) {
          //println(colorpinceau);
          g.tab1[lig][col].id = colorpinceau;
        }
      }
    }
    play = true;
  }
  if (editeurSelected ) {

    if (play) {
      int col = (mouseX - 100) / TAILLECASE;
      int lig = (mouseY - 100) / TAILLECASE;
      if (play) {
        if (dist(mouseX, mouseY, 872, 292)<=30)
          colorpinceau=0;
        else if (dist(mouseX, mouseY, 857, 402)<=30)
          colorpinceau=1;
        else if (dist(mouseX, mouseY, 783, 338)<=30)
          colorpinceau=2;
        else if (dist(mouseX, mouseY, 758, 422)<=30)
          colorpinceau=3;
        else if (dist(mouseX, mouseY, 818, 511)<=30)
          colorpinceau=4;
        else if (dist(mouseX, mouseY, 912, 500)<=30)
          colorpinceau=5;

        if (lig < g.lig && col < g.col &&lig>=0 && col>=0) {
          println(colorpinceau);
          g.tab1[lig][col].id = colorpinceau;
        }
      }
    }
    if(overButtonMenu){
    jeuSelected=false;     
    play=false;
    editeurSelected=false;
    }
  }
   if (display == 1) {
    int col = (mouseX-40) / TAILLECASE;
    int row = (mouseY-20) / TAILLECASE;

    if (col >= 0 && col < cols && row >= 0 && row < rows) {
      puzzle[row][col] = colorpinceau; // Inverser l'état de la case (255 -> 0, 0 -> 255)
    }
  }
}
void keyPressed() {
  if (key == 's' || key == 'S') {
    String Nom = Clavier.lireString("nom de votre Picross");
    savePuzzle(Nom);
  }
}

void savePuzzle(String filename) {
  String fullPath = folderPath + "/" + filename + ".txt";
  PrintWriter writer = createWriter(fullPath);

  writer.println(cols + " " + rows);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      writer.print(puzzle[i][j]+" ");
    }
    writer.println();
  }

  writer.println("6");



  writer.println("0 255 255 255");
  writer.println("1 0 0 0");
  writer.println("2 255 0 0");
  writer.println("3 0 255 0");
  writer.println("4 0 0 255");
  writer.println("5 255 255 0");



  writer.flush();
  writer.close();
}

void displayPuzzle() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      couleurs(puzzle[i][j]);
      rect(j * TAILLECASE+40, i * TAILLECASE+20, TAILLECASE, TAILLECASE);
    }
  }
}

void couleurs(int id) {
  if ( id == 5 ) {
    fill(255, 255, 0);
  } else if ( id == 4 ) {
    fill(0, 0, 255);
  } else if ( id == 3 ) {
    fill(0, 255, 0);
  } else if ( id == 2 ) {
    fill(255, 0, 0);
  } else if ( id == 1 ) {
    fill(0, 0, 0);
  } else if ( id == 0 ) {
    fill(255, 255, 255);
  }
}
