program prueba;
begin
    set_mode(m320x240);

    draw(1,5,5,0,0,120,320,120);
    draw(1,5,5,0,160,0,160,240);

    puntero();
    loop
        if (key(_esc))exit("",0);end
        frame;
    end
end

process puntero()
private
    cont;
    valor_y;
begin
    valor_y=x-40;

    x=160;
    y=120;
    put_pixel(x,y,40);
    x++;
    for (cont=0; cont=<50; cont++)
        y=valor_y;
        put_pixel(x,y,40);
        x++;
    end
end