PROGRAM racer;
BEGIN
    set_mode(m640x480);
    load_fpg("racer.fpg");
    put_screen(0,2);
    cafe(30,30);
    LOOP
        IF (key(_esc))
            exit("",0);
        END
        FRAME;
    END
END

PROCESS cafe(x,y)
PRIVATE
    eje_joystick[1];
    botones[1];
    contador;
    velocidad;

BEGIN
    write (0, 0, 0, 0, "Velocidad");
    write_int(0, 0, 10, 0, offset velocidad);

    graph=1;
    LOOP
        FROM contador=0 TO 1;
            eje_joystick[contador] = get_joy_position(contador);
            botones[contador] = get_joy_button(contador);
        END

        IF (eje_joystick[0] < 40)
            angle+=2000;
        END

        IF (eje_joystick[0] > 60)
            angle-=2000;
        END

        IF (botones[0] == 1)
            velocidad+=3;
            IF (velocidad > 10)
                velocidad=10;
            END
        END

        IF (botones[0] == 0)
            velocidad--;
        END

        IF (botones[1] == 1)
            velocidad-=2;
        END

        IF (velocidad<0)
            velocidad=0;
        END
        advance(velocidad);
        FRAME;
    END
END