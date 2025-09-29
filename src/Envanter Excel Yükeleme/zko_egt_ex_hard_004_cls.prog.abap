CLASS lcl_cls DEFINITION.
  PUBLIC SECTION.
    METHODS: start_screen,
      pbo_0100,
      pai_0100 IMPORTING iv_ucomm TYPE sy-ucomm,
      get_data,
      set_fcat,
      set_layout,
      display_alv,
      generate_excel,
      read_excel,
      insert_excel.

ENDCLASS.

CLASS lcl_cls IMPLEMENTATION.
  METHOD start_screen.
    CALL SCREEN 0100.
  ENDMETHOD.

  METHOD pbo_0100.
    SET PF-STATUS 'STATUS_0100'.
    go_main->get_data( ).
    go_main->set_fcat( ).
    go_main->set_layout( ).
    go_main->display_alv( ).
  ENDMETHOD.

  METHOD pai_0100.
    CASE iv_ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMETHOD.

  METHOD get_data.
    SELECT
      b~envanter_ad,
      b~adet,
      b~cname,
      b~cdate,
      b~ctime
      FROM zko_egt_t_envlis AS e
      INNER JOIN zko_egt_t_bakkod AS  b ON b~envanter_id EQ e~envanter_id
      INTO TABLE @gt_alvtable.
  ENDMETHOD.

  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZKO_EGT_S_ALV_ENVLIST'
      CHANGING
        ct_fieldcat      = gt_fcat.

  ENDMETHOD.

  METHOD set_layout.
    gs_layout-zebra = abap_true.
    gs_layout-cwidht_opt = abap_true.
    gs_layout-col_pos = abap_true.

  ENDMETHOD.

  METHOD display_alv.
    IF go_grid IS INITIAL.
      CREATE OBJECT go_container
        EXPORTING
          container_name = 'CC_ALV'.
      CREATE OBJECT go_grid
        EXPORTING
          i_parent = go_container.
      go_grid->set_table_for_first_display(
        EXPORTING
          is_layout                     = gs_layout
        CHANGING
          it_outtab                     = gt_alvtable
          it_fieldcatalog               = gt_fcat ).
    ENDIF.
  ENDMETHOD.

  METHOD generate_excel.
    CALL METHOD cl_gui_frontend_services=>directory_browse
      CHANGING
        selected_folder = gv_file.

    gv_file = gv_file
              && '\'
              && sy-datum
              && '_'
              && sy-uzeit
              &&'_'
              && 'envlis.xls'.

    gs_header-line = 'Envanter Id'.
    APPEND gs_header TO gt_header.
    gs_header-line = 'Adet'.
    APPEND gs_header TO gt_header.

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename              = gv_file
        filetype              = 'ASC'
        write_field_separator = 'X'
      TABLES
        data_tab              = gt_table
        fieldnames            = gt_header.
  ENDMETHOD.

  METHOD read_excel.
    CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
      EXPORTING
        i_line_header        = 'X'
        i_tab_raw_data       = gt_type
        i_filename           = p_file
      TABLES
        i_tab_converted_data = gt_table.
  ENDMETHOD.
