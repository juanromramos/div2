//Amuleto de Yendor

PROGRAM rogue;
GLOBAL
    fpg;

    STRUCT nivelY[11]
           nivelX[19];
    END

BEGIN
    fpg=load_fpg("rogue.fpg");
    start();
    LOOP
        IF (key(_esc))exit("Gracias",0);END
        FRAME;
    END
END

PROCESS start()
PRIVATE
    n;
    i;
BEGIN
    put_screen(0,200);
    delete_text(all_text);
    FOR (n=0; n<20; n++)           //
        FOR (i=0; i<12; i++)       // PONE TODA LA
            nivelY[i].nivelX[n]=0; // TABLA  A "0"
        END                        //
    END                            //

    tabla();
    genera_nivel();
    pinta_nivel();
END

PROCESS tabla()
PRIVATE
    n;
    i;
BEGIN
    delete_text(all_text);
    FOR (n=0; n<12; n++)
        FOR (i=0; i<20; i++)
            write_int(0,(i*10)+15,(n*10)+15,0,&nivelY[n].nivelX[i]);
            FRAME;
        END
    END
END

PROCESS genera_nivel()
PRIVATE
    n;
    pos_x;
    pos_y;
BEGIN
    FOR (n=0; n<20; n++)                        //
        nivelY[0].nivelX[n]=1;                  //
        nivelY[11].nivelX[n]=1;                 //
    END                                         //
                                                // PONE "1" EN TODO EL
    FOR (n=0; n<12; n++)                        // PERIMETRO DEL NIVEL
        nivelY[n].nivelX[0]=1;                  //
        nivelY[n].nivelX[19]=1;                 //
    END                                         //
    //////////////////////////////////////////////
    pos_x=rand(1,14); //<-tama¤o 5x5! cambiar!  //
    pos_y=rand(1,6);  //<-tama¤o 5x5! cambiar!  //
//    IF (pos_x%2!=0)pos_x++;END                  //
//    IF (pos_y%2!=0)pos_y++;END                  //
    FOR (n=0; n<5; n++)                         //
        nivelY[pos_y].nivelX[pos_x+n]=1;        //
        nivelY[pos_y+4].nivelX[pos_x+n]=1;      // GENERA   ALEATORIA-
    END                                         // MENTE  UNA  MAZMO-
    FOR (n=0; n<4; n++)                         // RRA  DE  5X5
        nivelY[pos_y+1+n].nivelX[pos_x]=1;      //
        nivelY[pos_y+1+n].nivelX[pos_x+4]=1;    //
    END                                         //
    //////////////////////////////////////////////
END

PROCESS pinta_nivel()
PRIVATE
    n;
    i;
BEGIN
    FOR (n=0; n<20; n++)                        //
        FOR (i=0; i<12; i++)                    //
            IF (nivelY[i].nivelX[n] == 0)       // RASTREA LA TABLA DEL
            put(fpg,201,(n*15)+10,(i*15)+10);END// NIVEL  Y   PINTA LOS
            IF (nivelY[i].nivelX[n] == 1)       // RECUADROS
            put(fpg,202,(n*15)+10,(i*15)+10);END//
        END                                     //
    END                                         //
    player();
END

PROCESS player()
PRIVATE
    pos_x;
    pos_y;
    hold_up;
    hold_right;
    hold_down;
    hold_left;

    n;
    i;
BEGIN
    graph=203;
    ////////////////////////////////////////////
    REPEAT                                    // HACE QUE EL PER-
        pos_x=rand(2,19);                     // SONAJE  NO  APA-
        pos_y=rand(2,11);                     // REZCA DENTRO  DE
        FRAME;                                // UN MURO
    UNTIL (nivelY[pos_y-1].nivelX[pos_x-1]==0)//
    ////////////////////////////////////////////
    hold_up=0;
    hold_right=0;
    hold_down=0;
    hold_left=0;
    REPEAT
        x=(pos_x*15)-5;
        y=(pos_y*15)-5;
        nivelY[pos_y-1].nivelX[pos_x-1]=1;

        IF (key(_up) AND pos_y>2 AND nivelY[pos_y-2].nivelX[pos_x-1]==0)
            nivelY[pos_y-1].nivelX[pos_x-1]=0;
            pos_y--;y-=15;nivelY[pos_y-1].nivelX[pos_x-1]=1;
            REPEAT
            FRAME;
            UNTIL (NOT key(_up))
        END
        IF (key(_right) AND pos_x<19 AND nivelY[pos_y-1].nivelX[pos_x]==0)
            nivelY[pos_y-1].nivelX[pos_x-1]=0;
            pos_x++;x+=15;nivelY[pos_y-1].nivelX[pos_x-1]=1;
            REPEAT
            FRAME;
            UNTIL (NOT key(_right))
        END
        IF (key(_down) AND pos_y<11 AND nivelY[pos_y].nivelX[pos_x-1]==0)
            nivelY[pos_y-1].nivelX[pos_x-1]=0;
            pos_y++;y+=15;nivelY[pos_y-1].nivelX[pos_x-1]=1;
            REPEAT
            FRAME;
            UNTIL (NOT key(_down))
        END
        IF (key(_left) AND pos_x>2 AND nivelY[pos_y-1].nivelX[pos_x-2]==0)
            nivelY[pos_y-1].nivelX[pos_x-1]=0;
            pos_x--;x-=15;nivelY[pos_y-1].nivelX[pos_x-1]=1;
            REPEAT
            FRAME;
            UNTIL (NOT key(_left))
        END
        FRAME;
    UNTIL (key(_space))
    start();
END

PROCESS room(tipo,pos_x,pos_y)
PRIVATE
    tipo;

    pos_x;
    pos_y;

    n;
    i;
BEGIN
    IF (pos_x%2==0)pos_x++;END
    IF (pos_y%2==0)pos_y++;END
    SWITCH (tipo)
        CASE 1:  //1x1 (tama¤o de 3x3 tiles)
            IF (pos_x>17)pos_x=17;END
            IF (pos_y>9)pos_y=9;END
            graph=101;

            FOR (n=-1; n<2; n++)
                FOR (i=-1; i<2; i++)
                    nivelY[pos_y+n].nivelX[pos_x+i]=2;
                END
            END
        END

        CASE 2:  //3x3 (tama¤o de 5x5 tiles)
            IF (pos_x>15)pos_x=15;END
            IF (pos_y>7)pos_y=7;END
            graph=102;
        END

        CASE 3:  //5x5 (tama¤o de 7x7 tiles)
            IF (pos_x>13)pos_x=13;END
            IF (pos_y>5)pos_y=5;END
            graph=103;
        END
    END
    REPEAT
        x=(pos_x*15)-5;
        y=(pos_y*15)-5;
        FRAME;
    UNTIL (key(_space))

    FOR (n=0; n<12; n++)
        FOR (i=0; i<20; i++)
            nivelY[n].nivelX[i]=0;
        END
    END
    delete_text(all_text);
    room(1,rand(1,20),rand(1,12));
END
