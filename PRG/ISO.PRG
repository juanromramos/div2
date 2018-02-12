//[]
program iso;

global
    fpg;

struct map_x[3]
    map_y[3];
end

begin
    fpg=load_fpg("iso.fpg");
    write_int(0,0,0,0,&mouse.x);
    write_int(0,0,8,0,&mouse.y);
    write(0,80,150,6,"PULSA ESPACIO PARA REGENERAR");
    mouse.graph=new_map(2,2,0,0,20);
    mundo();
    loop
        if (scan_code==_space)let_me_alone();mundo();end
        frame;
    end
end

process mundo()
private
    cont;
begin
    tile(141,51);

    tile(129,58);tile(153,58);

    tile(117,65);tile(141,65);tile(165,65);

    tile(105,72);tile(129,72);tile(153,72);tile(177,72);

    tile(117,79);tile(141,79);tile(165,79);

    tile(129,86);tile(153,86);

    tile(141,93);
end

process tile(x,y)
private
    cont;
begin
    graph=rand(10,13);
    loop
        if (graph==13)
            loop
                cont++;
                if (cont=>10)cont=0;graph++;end
                if (graph>14)graph=13;end
                frame;
            end
        end
        frame;
    end
end