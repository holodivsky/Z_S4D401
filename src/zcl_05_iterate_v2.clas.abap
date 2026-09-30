CLASS zcl_05_iterate_v2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_iterate_v2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: max_count TYPE i VALUE 10,
          numbers   TYPE TABLE OF i,
          output    TYPE TABLE OF string.


    DO max_count TIMES.

      IF sy-index = 0.
        APPEND 0 TO numbers.
      ELSEIF sy-index = 1.
        APPEND 1 TO numbers.
      ELSE.
        APPEND numbers[ sy-index - 1 ] + numbers[ sy-index - 2 ] TO numbers.
      ENDIF.
      APPEND sy-index TO numbers.
    ENDDO.


    DATA(counter) = 0.
    LOOP AT numbers INTO DATA(number).
      counter = counter + 1.
      APPEND |{ counter WIDTH = 4 ALIGN = LEFT }: { number WIDTH = 10 ALIGN = RIGHT }| TO output.

    ENDLOOP.

    out->write( data = output name = |The first { max_count } Fibonacci Numbers| ) .


  ENDMETHOD.
ENDCLASS.
