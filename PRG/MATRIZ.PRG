program matriz;
global
    fpg;

    direc; //1.NORTE 2.ESTE 3.SUR 4.OESTE

    pos_x;
    pos_y;

    pos_9;pos_10;pos_11;
    pos_6;pos_7; pos_8;
    pos_3;pos_4; pos_5;
    pos_1;       pos_2;
    pos_bck;


    struct mapy[9]
        mapx[9];
    end = 1,1,1,1,1,1,1,1,1,1,
          1,0,0,0,0,0,1,0,0,1,
          1,0,1,1,0,0,1,0,0,1,
          1,0,1,1,0,1,1,1,0,1,
          1,0,1,1,0,0,1,0,0,1,
          1,0,0,0,0,0,0,0,0,1,
          1,0,1,1,1,1,0,1,1,1,
          1,0,1,0,0,0,0,0,0,1,
          1,0,1,0,1,0,1,0,0,1,
          1,1,1,1,1,1,1,1,1,1;

begin
    fpg=load_fpg("matriz.fpg");
    mouse.graph=new_map(1,1,0,0,15);
    mapa();
    loop
        if (key(_space) OR key(_esc))exit("",0);end
        frame;
    end
end

process mapa()
private
    n;
    i;
begin
    for (n=0; n<10; n++)
        for (i=0; i<10; i++)
            if (mapy[n].mapx[i] == 1)draw(3,19,15,0,(i*10)+6,(n*10)+6,(i*10)+14,(n*10)+14);end
            draw(1,15,15,0,(i*10)+5,5,(i*10)+5,104); //VERTICAL
        end
        draw(1,15,15,0,5,(n*10)+5,104,(n*10)+5); //HORIZONTAL
    end
    draw(2,15,15,0,5,5,105,105);
    marco();
    cursor();
end

process posiciona()
begin
    loop
        ignore_error(140);
            if (direc==1)
            pos_11=mapy[pos_y-3].mapx[pos_x+1];
            pos_10=mapy[pos_y-3].mapx[pos_x];
            pos_9=mapy[pos_y-3].mapx[pos_x-1];
            pos_8=mapy[pos_y-2].mapx[pos_x+1];
            pos_7=mapy[pos_y-2].mapx[pos_x];
            pos_6=mapy[pos_y-2].mapx[pos_x-1];
            pos_5=mapy[pos_y-1].mapx[pos_x+1];
            pos_4=mapy[pos_y-1].mapx[pos_x];
            pos_3=mapy[pos_y-1].mapx[pos_x-1];
            pos_2=mapy[pos_y].mapx[pos_x+1];
            pos_1=mapy[pos_y].mapx[pos_x-1];
            pos_bck=mapy[pos_y+1].mapx[pos_x];
        end
        if (direc==2)
            pos_11=mapy[pos_y+1].mapx[pos_x+3];
            pos_10=mapy[pos_y].mapx[pos_x+3];
            pos_9=mapy[pos_y-1].mapx[pos_x+3];
            pos_8=mapy[pos_y+1].mapx[pos_x+2];
            pos_7=mapy[pos_y].mapx[pos_x+2];
            pos_6=mapy[pos_y-1].mapx[pos_x+2];
            pos_5=mapy[pos_y+1].mapx[pos_x+1];
            pos_4=mapy[pos_y].mapx[pos_x+1];
            pos_3=mapy[pos_y-1].mapx[pos_x+1];
            pos_2=mapy[pos_y+1].mapx[pos_x];
            pos_1=mapy[pos_y-1].mapx[pos_x];
            pos_bck=mapy[pos_y].mapx[pos_x-1];
        end
        if (direc==3)
            pos_11=mapy[pos_y+3].mapx[pos_x-1];
            pos_10=mapy[pos_y+3].mapx[pos_x];
            pos_9=mapy[pos_y+3].mapx[pos_x+1];
            pos_8=mapy[pos_y+2].mapx[pos_x-1];
            pos_7=mapy[pos_y+2].mapx[pos_x];
            pos_6=mapy[pos_y+2].mapx[pos_x+1];
            pos_5=mapy[pos_y+1].mapx[pos_x-1];
            pos_4=mapy[pos_y+1].mapx[pos_x];
            pos_3=mapy[pos_y+1].mapx[pos_x+1];
            pos_2=mapy[pos_y].mapx[pos_x-1];
            pos_1=mapy[pos_y].mapx[pos_x+1];
            pos_bck=mapy[pos_y-1].mapx[pos_x];
        end
        if (direc==4)
            pos_11=mapy[pos_y-1].mapx[pos_x-3];
            pos_10=mapy[pos_y].mapx[pos_x-3];
            pos_9=mapy[pos_y+1].mapx[pos_x-3];
            pos_8=mapy[pos_y-1].mapx[pos_x-2];
            pos_7=mapy[pos_y].mapx[pos_x-2];
            pos_6=mapy[pos_y+1].mapx[pos_x-2];
            pos_5=mapy[pos_y-1].mapx[pos_x-1];
            pos_4=mapy[pos_y].mapx[pos_x-1];
            pos_3=mapy[pos_y+1].mapx[pos_x-1];
            pos_2=mapy[pos_y-1].mapx[pos_x];
            pos_1=mapy[pos_y+1].mapx[pos_x];
            pos_bck=mapy[pos_y].mapx[pos_x+1];
        end
        if (scan_code!=0)pinta_mundo(pos_x,pos_y);end
        frame;
    end
end

process cursor()
begin
    direc=1;    //POSICION INICIAL
    pos_x=1;    //MIRANDO AL SUR [3]
    pos_y=7;    //ABAJO A LA IZQ. DEL MAPA [1,8]
    posiciona();

    pinta_mundo(pos_x,pos_y);
    loop
        x=(pos_x*10)+10;
        y=(pos_y*10)+10;
        if (direc==1)graph=6;flags=0;end
        if (direc==2)graph=7;flags=0;end
        if (direc==3)graph=6;flags=2;end
        if (direc==4)graph=7;flags=1;end

        if (scan_code==_q)direc-=1;
            if (direc<1)direc=4;end
        end

        if (scan_code==_e)direc+=1;
            if (direc>4)direc=1;end
        end

        if (scan_code==_w and pos_4==0)
            if (direc==1)pos_y--;end
            if (direc==2)pos_x++;end
            if (direc==3)pos_y++;end
            if (direc==4)pos_x--;end
        end

        if (scan_code==_s and pos_bck==0)
            if (direc==1)pos_y++;end
            if (direc==2)pos_x--;end
            if (direc==3)pos_y--;end
            if (direc==4)pos_x++;end
        end

        if (scan_code==_a and pos_1==0)
            if (direc==1)pos_x--;end
            if (direc==2)pos_y--;end
            if (direc==3)pos_x++;end
            if (direc==4)pos_y++;end
        end

        if (scan_code==_d and pos_2==0)
            if (direc==1)pos_x++;end
            if (direc==2)pos_y++;end
            if (direc==3)pos_x--;end
            if (direc==4)pos_y--;end
        end
        frame;
    end
end

process pinta_mundo(pos_x,pos_y)
begin
    if (pos_1==1)pared(1);
        if (pos_3==0 and pos_6==1)pared(9);end
        else if (pos_3==1)pared(4);
                else if (pos_6==1)pared(9);end
             end
    end
    if (pos_2==1)pared(2);
        if (pos_5==0 and pos_8==1)pared(12);end
        else if (pos_5==1)pared(7);
                else if (pos_8==1)pared(12);end
             end
    end
    if (pos_4==1)pared(5);
        else if (pos_3==1)pared(3);end
             if (pos_5==1)pared(6);end
             if (pos_6==1 and pos_7==0)pared(8);end
             if (pos_8==1 and pos_7==0)pared(11);end

             if (pos_7==1)pared(10);
                else if (pos_6==0 and pos_9==1)pared(14);end
                     if (pos_8==0 and pos_11==1)pared(17);end
                     if (pos_10==1)pared(15);
                        else if (pos_9==1)pared(13);end
                             if (pos_11==1)pared(16);end
                     end
             end
    end
end

//13.14.     15.     16.17.
//8.9.       10.     11.12.
//3.4.       5.      6.7.
//1.                 2.

process pared(tipo)
begin
    switch (tipo)
        case 1:
            graph=101;
            x=120;
            y=6;
        end
        case 2:
            graph=101;flags=1;
            x=313;
            y=6;
        end
        case 3:
            graph=102;
            x=166;
            y=43;
        end
        case 4:
            graph=108;
            x=120;
            y=43;
        end
        case 5:
            graph=105;
            x=166;
            y=43;
        end
        case 6:
            graph=102;flags=1;
            x=267;
            y=43;
        end
        case 7:
            graph=109;
            x=267;
            y=43;
        end
        case 8:
            graph=103;
            x=197;
            y=67;
        end
        case 9;
            graph=106;
            x=158;
            y=67;
            z=1;
        end
        case 10:
            graph=106;
            x=197;
            y=67;
        end
        case 11:
            graph=103;flags=1;
            x=236;
            y=67;
        end
        case 12;
            graph=106;
            x=236;
            y=67;
            z=1;
        end
        case 13;
            graph=104;
            x=207;
            y=75;
        end
        case 14;
            graph=107;
            x=188;
            y=75;
            z=1;
        end
        case 15;
            graph=107;
            x=207;
            y=75;
        end
        case 16;
            graph=104;flags=1;
            x=226;
            y=75;
        end
        case 17;
            graph=107;
            x=226;
            y=75;
            z=1;
        end
    end
    repeat
        frame;
    until (scan_code!=0)
end

process marco()
begin
    graph=1;
    draw(2,15,15,0,119,5,314,160);
    draw(3,5,15,0,120,6,313,82);
    draw(3,9,15,0,120,83,313,159);
    draw_z=10;
    x=119;
    y=5;
    z=2;
    loop
        frame;
    end
end

/*
        if (scan_code==_w and direc==1 and posic_arr==0)posic_y--;end
        if (scan_code==_w and direc==3 and posic_aba==0)posic_y++;end
        if (scan_code==_w and direc==2 and posic_der==0)posic_x++;end
        if (scan_code==_w and direc==4 and posic_izq==0)posic_x--;end

        if (scan_code==_s and direc==1 and posic_aba==0)posic_y++;end
        if (scan_code==_s and direc==3 and posic_arr==0)posic_y--;end
        if (scan_code==_s and direc==2 and posic_izq==0)posic_x--;end
        if (scan_code==_s and direc==4 and posic_der==0)posic_x++;end

        if (scan_code==_a and direc==1 and posic_izq==0)posic_x--;end
        if (scan_code==_a and direc==3 and posic_der==0)posic_x++;end
        if (scan_code==_a and direc==2 and posic_arr==0)posic_y--;end
        if (scan_code==_a and direc==4 and posic_aba==0)posic_y++;end

        if (scan_code==_d and direc==1 and posic_der==0)posic_x++;end
        if (scan_code==_d and direc==3 and posic_izq==0)posic_x--;end
        if (scan_code==_d and direc==2 and posic_aba==0)posic_y++;end
        if (scan_code==_d and direc==4 and posic_arr==0)posic_y--;end

    for (n=0; n<4; n++)
        for (i=0; i<4; i++)
            write_int(0,n*10,i*10,0,&mapy[n].mapx[i]);
        end
    end

    draw(2,15,15,0,10,10,30,30);
    draw(1,15,15,0,10,15,30,15);
    draw(1,15,15,0,10,20,30,20);
    draw(1,15,15,0,10,25,30,25);
    draw(1,15,15,0,15,10,15,30);
    draw(1,15,15,0,20,10,20,30);
    draw(1,15,15,0,25,10,25,30);

    if (map[0]==1)draw(3,19,15,0,11,11,14,14);end
    if (map[1]==1)draw(3,19,15,0,16,11,19,14);end
    if (map[2]==1)draw(3,19,15,0,21,11,24,14);end
    if (map[3]==1)draw(3,19,15,0,26,11,29,14);end

    if (map[4]==1)draw(3,19,15,0,11,16,14,19);end
    if (map[5]==1)draw(3,19,15,0,16,16,19,19);end
    if (map[6]==1)draw(3,19,15,0,21,16,24,19);end
    if (map[7]==1)draw(3,19,15,0,26,16,29,19);end

    if (map[8]==1)draw(3,19,15,0,11,21,14,24);end
    if (map[9]==1)draw(3,19,15,0,16,21,19,24);end
    if (map[10]==1)draw(3,19,15,0,21,21,24,24);end
    if (map[11]==1)draw(3,19,15,0,26,21,29,24);end

    if (map[12]==1)draw(3,19,15,0,11,26,14,29);end
    if (map[13]==1)draw(3,19,15,0,16,26,19,29);end
    if (map[14]==1)draw(3,19,15,0,21,26,24,29);end
    if (map[15]==1)draw(3,19,15,0,26,26,29,29);end*/