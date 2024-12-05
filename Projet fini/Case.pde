class Case {

  int id;
  int lig, col; 

  void initCase(int l, int c) {

    this.lig=l;
    this.col=c;
    this.id = 0;
  }
  void dessin(int tabcolor [][],int nbcolor) {
      
     if( id == 0 && id<=nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else if( id == 1 && id<=nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else if( id == 2 && id<nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else if( id == 3 && id<nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else if( id == 4 && id<nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else if( id == 5 && id<nbcolor ){
      fill(tabcolor[id][1],tabcolor[id][2],tabcolor[id][3]);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }else{
      fill(255,255,255);
      rect(TAILLECASE*col+100, TAILLECASE*lig+100, TAILLECASE, TAILLECASE);
    }
  }
}
