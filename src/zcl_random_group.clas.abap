CLASS zcl_random_group DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_person,
             nachname TYPE string,
             vorname  TYPE string,
           END OF ty_person.
    TYPES ty_persons  TYPE STANDARD TABLE OF ty_person WITH EMPTY KEY.

    TYPES: BEGIN OF ty_result,
             gruppe   TYPE i,
             nachname TYPE string,
             vorname  TYPE string,
           END OF ty_result.
    TYPES ty_results  TYPE STANDARD TABLE OF ty_result.
ENDCLASS.



CLASS zcl_random_group IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lt_pool) = VALUE ty_persons(
      ( nachname = `Ahmed`            vorname = `Moustafa Salah Sobhy` )
      ( nachname = `Ergün`            vorname = `Oguzhan` )
      ( nachname = `Ghazal`            vorname = `Samir Soleiman` )
      ( nachname = `Görgün`           vorname = `Kenan` )
      ( nachname = `Holodivskyi`      vorname = `Volodymyr` )
      ( nachname = `Jung`             vorname = `Tobias` )
      ( nachname = `Kabak`            vorname = `Waseem` )
      ( nachname = `Kameni Latchepen` vorname = `Ines` )
      ( nachname = `Kochnev`          vorname = `Maxim` )
      ( nachname = `Schmelz`          vorname = `Georgette Solange Aimee` )
      ( nachname = `Tshisola`         vorname = `Ndondji Steve` )
      ( nachname = `Bobrova`          vorname = `Svetlana` )
      ( nachname = `Chacko`           vorname = `Neena` )
      ( nachname = `Uslu`             vorname = `Mustafa Yilmaz` ) ).


    DATA lt_result TYPE ty_results.

    CONSTANTS mc_groups TYPE i VALUE 3.

    DATA(lo_rand)  = cl_abap_random=>create( seed = cl_abap_random=>seed( ) ).
    DATA(lv_group) = lo_rand->intinrange( low = 1 high = mc_groups ).

    WHILE lt_pool IS NOT INITIAL.
      DATA(lv_i) = lo_rand->intinrange( low = 1 high = lines( lt_pool ) ).

      APPEND VALUE #( gruppe   = lv_group
                      nachname = lt_pool[ lv_i ]-nachname
                      vorname  = lt_pool[ lv_i ]-vorname ) TO lt_result.

      DELETE lt_pool INDEX lv_i.
      lv_group = lv_group MOD mc_groups + 1.
*      lv_group = COND #( WHEN lv_group = mc_groups THEN 1 ELSE lv_group + 1 ).
    ENDWHILE.

    SORT lt_result BY gruppe nachname.

    out->write( lt_result ).
  ENDMETHOD.
ENDCLASS.
