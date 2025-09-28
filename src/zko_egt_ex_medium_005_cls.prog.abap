CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS: start_screen,
      pbo_0100,
      pai_0100 IMPORTING iv_ucomm TYPE sy-ucomm,
      get_data,
      set_fcat,
      set_layout,
      display_alv.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD start_screen.
    CALL SCREEN 0100.
  ENDMETHOD.

  METHOD pbo_0100.
    SET PF-STATUS 'STATUS_0100'.
    me->get_data( ).
    me->set_fcat( ).
    me->set_layout( ).
    me->display_alv( ).
  ENDMETHOD.

  METHOD pai_0100.
    CASE iv_ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMETHOD.

  METHOD get_data.
    DATA: lt_perstab TYPE TABLE OF zko_egt_t_persv2.
    SELECT * FROM zko_egt_t_persv2 INTO  TABLE lt_perstab.

    LOOP AT lt_perstab INTO DATA(d_pers2).
      gv_ttlyr = gv_ttlyr + d_pers2-pers_yil.
    ENDLOOP.

    LOOP AT lt_perstab INTO DATA(d_pers).
      gs_alvtable-pers_id = d_pers-pers_id.
      gs_alvtable-pers_ad = d_pers-pers_ad.
      gs_alvtable-pers_soyad = d_pers-pers_soyad.
      gs_alvtable-pers_yil = d_pers-pers_yil.
      gs_alvtable-ikr_mikt = d_pers-pers_yil * ( p_butce / gv_ttlyr ).

      APPEND gs_alvtable TO gt_alvtable.
      CLEAR gs_alvtable.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'zko_egt_s_pers_ikr'
      CHANGING
        ct_fieldcat      = gt_fcat.
  ENDMETHOD.

  METHOD set_layout.
    gs_layout-zebra = 'X'.
    gs_layout-cwidht_opt = 'X'.
    gs_layout-col_opt = 'X'.
  ENDMETHOD.

  METHOD display_alv.

    IF go_grid IS INITIAL.
      CREATE OBJECT go_container
        EXPORTING
          container_name = 'CC_ALV'.
      CREATE OBJECT go_grid
        EXPORTING
          i_parent = go_container.
      go_grid->set-table_for_first_display(
      EXPORTING
        is_layout = gs_layout
        CHANGING
          it_outtab = gt_alvtable
          it_fieldcatalog = gt_fcat
          ).
    ELSE.
      CALL METHOD go_grid->refresh_table_display.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
