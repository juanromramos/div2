//Amuleto de Yendor
//Puerta con llave/llave
//Escaleras
//Todo aleatorio

PROGRAM roguemas;

CONST
    n_max_X=99;           // TAMA¥O  DE  LA
    n_max_Y=99;           // TABLA COMPLETA

                          // TAMA¥O DE NIVEL
                          // X10Y6 - X89Y93
                          // 80x88

    n_x_inicio=9;         // COORDENADAS XY
    n_x_final=90;         // DEL  PERIMETRO
    n_y_inicio=5;         // DEL NIVEL
    n_y_final=94;         //

    n_player_graphX= 160; // COORDENADAS DEL
    n_player_graphY= 100; // SPRITE DEL JUG.

    n_suelo=1;            // CONSTANTES DE LOS
    n_muro=0;             // CODIGOS  DE  CADA
    n_player=8;           // TILES
    n_agua=2;

    tile_size=15;
GLOBAL
    fpg;

    tiles[]=".", //1 SUELO
            "O", //0 MURO
            "@", //8 JUGADOR
            "W"; //2 AGUA

    STRUCT nivelY[99]  //11
           nivelX[99]; //19
    END

    posX;
    posY;

    ascii_mode=false;

    n_tile_anim;          // CODIGO PROCESO

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
    clear_screen();
    delete_text(all_text);
    FOR (n=0; n<n_max_Y+1; n++)         //
        FOR (i=0; i<n_max_X+1; i++)     // PINTA "SUELO" EN
            nivelY[i].nivelX[n]=n_suelo;// TODA   LA  TABLA
        END                             //
    END

    write_int(0,0,0,0,&posX);
    write_int(0,0,10,0,&posY);

    nivelY[9].nivelX[12]=n_agua;
    nivelY[10].nivelX[12]=n_agua;
    nivelY[9].nivelX[13]=n_agua;
    nivelY[10].nivelX[13]=n_agua;

    draw(2,5,15,0,10,10,310,190);
    mouse.graph=5;
    genera_nivel();
    control_player();
END

PROCESS control_player()
BEGIN
    posX=10;
    posY=6;
    nivelY[posY].nivelX[posX]=n_player;
    pinta_nivel();
    REPEAT
//        IF (key(_i))ascii_mode=true;END
//        IF (key(_o))ascii_mode=false;END

        IF (mouse.left AND mouse.x>167 AND mouse.x<190
                       AND mouse.y>100 AND mouse.y<115
                       AND nivelY[posY].nivelX[posX+1]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posX++;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT mouse.left)
        END

        IF (mouse.left AND mouse.x<167 AND mouse.x>145
                       AND mouse.y>100 AND mouse.y<115
                       AND nivelY[posY].nivelX[posX-1]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posX--;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT mouse.left)
        END

        IF (mouse.left AND mouse.y<107 AND mouse.y>85
                       AND mouse.x>145 AND mouse.x<190
                       AND nivelY[posY-1].nivelX[posX]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posY--;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT mouse.left)
        END

        IF (mouse.left AND mouse.y>107 AND mouse.y<130
                       AND mouse.x>145 AND mouse.x<190
                       AND nivelY[posY+1].nivelX[posX]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posY++;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT mouse.left)
        END


        IF (key(_up) AND nivelY[posY-1].nivelX[posX]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posY--;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT key(_up))
        END

        IF (key(_right) AND nivelY[posY].nivelX[posX+1]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posX++;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT key(_right))
        END

        IF (key(_down) AND nivelY[posY+1].nivelX[posX]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posY++;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT key(_down))
        END

        IF (key(_left) AND nivelY[posY].nivelX[posX-1]==n_suelo)
            nivelY[posY].nivelX[posX]=n_suelo;
            posX--;nivelY[posY].nivelX[posX]=n_player;
            pinta_nivel();
            REPEAT
            FRAME;
            UNTIL (NOT key(_left))
        END
        FRAME;
    UNTIL (key(_space))
    signal(n_tile_anim,s_kill);
    start();
END

PROCESS genera_nivel()
PRIVATE
    n;
    i;
BEGIN
    FOR (n=0; n<n_max_Y+1; n++)
        FOR (i=0; i<n_y_inicio+1; i++)
        nivelY[i].nivelX[n]=n_muro;
        nivelY[i+n_y_final].nivelX[n]=n_muro;
        END
    END

    FOR (n=0; n<n_x_inicio+1; n++)
        FOR (i=0; i<n_max_X+1; i++)
        nivelY[i].nivelX[n]=n_muro;
        nivelY[i].nivelX[n+n_x_final]=n_muro;
        END
    END
END

PROCESS pinta_nivel()
PRIVATE
    n;
    i;

    n_max[1]=20,12; //20,12
    n_pos[1]=10,10;
BEGIN
    clear_screen();
    put_screen(0,6);
    FOR (n=0; n<n_max[1]; n++)                                 //
        FOR (i=0; i<n_max[0]; i++)                             //
            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_suelo  //
            OR nivelY[n+posY-6].nivelX[i+posX-10] == n_player) //
            put(fpg,201,(i*tile_size)+n_pos[0],                //
                        (n*tile_size)+n_pos[1]);END            // RASTREA   LA
            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_player)//
                put(fpg,204,n_player_graphX,n_player_graphY);  //
            END                                                //
                                                               // TABLA Y PIN-
            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_muro)  // TA CADA TILE
            put(fpg,202,(i*tile_size)+n_pos[0],                //
                        (n*tile_size)+n_pos[1]);END            //
            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_agua)  //
            put(fpg,7,(i*tile_size)+n_pos[0]+7,                //
                      (n*tile_size)+n_pos[1]+7);END            //
        END                                                    //
    END                                                        //
   // grafico_player();
   // n_tile_anim=tile_anim(1,x,y);
    IF (ascii_mode == true)tabla();END

END

PROCESS tabla()
PRIVATE
    n;
    i;

    n_max_text[1]=20,12; // TAMA¥O DE LA TABLA (20X12)
    n_pos_text[1]=15,15; // POSICIONA LA  TABLA
BEGIN
    delete_text(all_text);
    FOR (n=0; n<n_max_text[1]; n++)
        FOR (i=0; i<n_max_text[0]; i++)
            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_suelo)
            write(0,(i*tile_size)+n_pos_text[0],
                    (n*tile_size)+n_pos_text[1],0,tiles[0]);END

            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_muro)
            write(0,(i*tile_size)+n_pos_text[0],
                    (n*tile_size)+n_pos_text[1],0,tiles[1]);END

            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_player)
            write(0,(i*tile_size)+n_pos_text[0],
                    (n*tile_size)+n_pos_text[1],0,tiles[2]);END

            IF (nivelY[n+posY-6].nivelX[i+posX-10] == n_agua)
            write(0,(i*tile_size)+n_pos_text[0],
                    (n*tile_size)+n_pos_text[1],0,tiles[3]);END
        END
    END
END

PROCESS tile_anim(tipo,x,y)
PRIVATE
    n;
BEGIN
    SWITCH (tipo)
        CASE 1:          // PLAYER
            put(fpg,203,n_player_graphX,n_player_graphY);
        END

        CASE 2:          // AGUA
             graph=7;
             flags=0;
             x+=7;
             y+=7;
             LOOP
                n++;
                IF (n=>10)flags++;n=0;END
                IF (flags>1)flags=0;END
                FRAME;
             END
        END
    END
END