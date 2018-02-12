/*
 * castlevania.PRG by juan
 * (c) 2017 noone
 */

PROGRAM castlevania;

BEGIN
    set_mode(m320x240);
    load_fpg("simon.fpg");
    simon();
    LOOP
        IF (key(_esc))exit("",0);END
        FRAME;
    END
END

PROCESS simon()
PRIVATE
    cont_anim=0;
    salto;
BEGIN
    put_screen(0,100);
    graph=1;
    x=40;
    y=10;//y=133;
    controla_gravedad();
    //write_int(0,0,0,0,OFFSET cont_anim);
    /*
    pon_transparente(1);
    pon_transparente(2);
    pon_transparente(3);
    pon_transparente(8);
    */
    LOOP
        IF (key(_left) OR key(_right))
            graph=2;
            WHILE (key(_left) OR key(_right))
                IF (key(_left))x-=2;flags=1;END
                IF (key(_right))x+=2;flags=0;END
                IF (key(_left) AND key(_right))BREAK;END

                cont_anim++;
                IF (cont_anim>3)cont_anim=0;graph++;END
                IF (graph>3)graph=2;END
                FRAME;
            END
        END

        //IF (key(_z))graph=8;y-=10;END

        IF (key(_down))
            graph=8;
            WHILE (key(_down))
                FRAME;
            END
        END

        cont_anim=0;
        graph=1;
        FRAME;
    END
END

PROCESS controla_gravedad()
BEGIN
    LOOP
        father.y+=5;
        IF (father.y>133)father.y=133;END
        FRAME;
    END
END

PROCESS pon_transparente(cod_graf)
PRIVATE
    ancho;alto;
    i;j;
BEGIN
    ancho=graphic_info(0,cod_graf,g_wide);
    alto=graphic_info(0,cod_graf,g_height);
    FOR (i=0; i<alto; i++)
        FOR (j=0; j<ancho; j++)
            IF (i%2 == j%2)map_put_pixel(0,cod_graf,j,i,0);END
        END
    END
END