program rol;
global
    fpg;
    linea1;
    linea2;
    linea3;
    linea4;
begin
    fpg=load_fpg("rol.fpg");
    inicio();
end

process inicio()
begin
    mouse.graph=1;
    jugador();
    enemigo();
    loop
        if (key(_esc))exit("gracias por jugar",0);end
        frame;
    end
end

process jugador()
private
    fuerza;
    defensa;
    vida;

    dado1;
    dado2;
begin
    clear_screen();
    write(0,0,32,0,"FUERZA:");
    write(0,0,40,0,"DEFENSA:");
    write(0,0,48,0,"VIDA:");

    escribe(1,"Probemos cu l es tu fuerza...");

    timer[0]=0;
    repeat
        if (timer[0]=>150)escribe(2,"Pulsa ESPACIO");end
        frame;
    until (timer[0]=>150 AND scan_code==_space)
    dado1=rand(1,6);
    dado2=rand(1,6);
    xput(0,dado1+10,38,168,(rand(0,270))*1000,100,1,1);
    put(0,dado2+10,60,168);
    fuerza=dado1+dado2;

    write_int(0,48,32,0,&fuerza);

    escribe(1,"Midamos ahora tu defensa...");

    timer[0]=0;
    repeat
        if (timer[0]=>150)escribe(2,"Pulsa ESPACIO");end
        frame;
    until (timer[0]=>150 AND scan_code==_space)
    clear_screen();

    dado1=rand(1,6);
    dado2=rand(1,6);

    put(0,dado1+10,38,168);
    put(0,dado2+10,60,168);
    defensa=dado1+dado2;

    write_int(0,48,40,0,&defensa);
    escribe(1,"Por £ltimo, veamos cu nta vitalidad posees...");

    timer[0]=0;
    repeat
        if (timer[0]=>150)escribe(2,"Pulsa ESPACIO");end
        frame;
    until (timer[0]=>150 AND scan_code==_space)
    dado1=rand(1,6);
    dado2=rand(1,6);

    put(0,dado1+10,38,168);
    put(0,dado2+10,60,168);
    vida=dado1+dado2;
    write_int(0,48,48,0,&vida);

    escribe(1,"Vale por hoy");

    timer[0]=0;
    repeat
        if (timer[0]=>150)escribe(2,"Pulsa R para reiniciar");end
        frame;
    until (timer[0]=>150 AND scan_code==_r)
    let_me_alone();
    clear_screen();
    delete_text(all_text);
    inicio();
end

process escribe(linea,texto)
begin
    switch (linea)
        case 1:
            write(0,0,0,0,texto);
        end
        case 2:
            write(0,0,8,0,texto);
        end
    end
end

process enemigo()
begin
    graph=2;
    x=160;
    y=100;
    loop
        frame;
    end
end