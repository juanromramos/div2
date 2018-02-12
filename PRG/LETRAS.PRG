// CONTROL+"M"+"J": salto de l¡nea    (13+10)
// ESC: guardar y salir
// []
// TAREAS: no guarda m s de 256 caracteres (dividir en bloques?)
program letras;
global
    struct pag[44]    //45 PAGINAS
        string Linea;
    end

    string textoCompleto;
    string escribiendoLinea;
    string lineaEscrita;

    fileId;
    textoEscribiendo;
    contLineas=0;

    longLinea;
    longDocum;
begin
    set_mode(m640x480);
    save("texto.txt",textoCompleto,300);
    textoEscribiendo=write(0,0,contLineas*10,0,escribiendoLinea);

    cursor();

//    write_int(0,100,200,0,&longLinea);
//    write_int(0,100,210,0,&longDocum);
end

process cursor()
begin
    repeat
        longLinea=strlen(escribiendoLinea);
        longDocum=strlen(textoCompleto);

        if (longLinea=>100)
            salto();
        end

        if (scan_code != 0 AND scan_code != 1     //ESC - "SALIR"
                            AND scan_code != 28   //ENTER - "SALTO"
                            AND scan_code != 14)  //RETROCESO - "BORRAR"
            escribiendoLinea+=ascii;
            while (scan_code != 0)
                frame;
            end
        end

        if (scan_code == 28 AND contLineas<44)  //ENTER
            salto();
        end

        if (scan_code == 14)  //RETROCESO
            escribiendoLinea-=1;
            while (scan_code != 14)
                frame;
            end
        end

        frame;
    until (scan_code == 1)
    textoCompleto=textoCompleto+escribiendoLinea;
    save("texto.txt",textoCompleto,sizeof (textoCompleto));
    exit("",0);
end

function salto()
begin
    textoCompleto=textoCompleto+escribiendoLinea;
    pag[contLineas].Linea=escribiendoLinea;

    delete_text(textoEscribiendo);
    write(0,0,contLineas*10,0,pag[contLineas].Linea);

    textoCompleto+=13; //SIMBOLOS   DEL
    textoCompleto+=10; //SALTO DE LINEA

    escribiendoLinea=0;

    contLineas++;
    textoEscribiendo=write(0,0,contLineas*10,0,escribiendoLinea);
end