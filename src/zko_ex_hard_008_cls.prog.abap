CLASS lcl_class DEFINITION.
  PUBLIC SECTION.
    METHODS: start_screen_0100,
      start_screen_0200,
      pbo_0100,
      pai_0100 IMPORTING iv_ucomm TYPE sy-ucomm,
      pbo_0200,
      get_progcount_data,
      get_progdetail_data IMPORTING iv_cnam TYPE cnam,
      set_fcat IMPORTING iv_screenno TYPE numc1,
      set_layout,
      display_alv IMPORTING iv_screenno TYPE numc1,
      handle_hotspot_click
                  FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id
                  e_column_id.
ENDCLASS.

CLASS lcl_class IMPLEMENTATION.
  METHOD start_screen_0100.
    CALL SCREEN 0100.
  ENDMETHOD.

  METHOD start_screen_0200.
    CALL SCREEN 0200.
  ENDMETHOD.

  METHOD pbo_0100.
    SET PF-STATUS 'STATUS_0100'.
    go_main->get_progcount_data( ).
    go_main->set_fcat( iv_screenno = 1 ).
    go_main->set_layout( ).
    go_main->display_alv( iv_screenno = 1 ).
  ENDMETHOD.

  METHOD pbo_0200.
    SET PF-STATUS 'STATUS_0100'.
    go_main->set_fcat( iv_screenno = 2 ).
    go_main->set_layout( ).
    go_main->display_alv( iv_screenno = 2 ).
  ENDMETHOD.

  METHOD pai_0100.
    CASE iv_ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMETHOD.

  METHOD get_progcount_data.
    SELECT cnam, COUNT( * ) AS prog_count FROM reposrc
      INTO TABLE @gt_progcount_alvtable
      GROUP BY cnam.
  ENDMETHOD.

  METHOD get_progdetail_data.
    SELECT cnam, progname, cdat, vern, datalg FROM reposrc
      INTO CORRESPONDING FIELDS OF TABLE @gt_progdetail_alvtable
      WHERE cnam = @iv_cnam.
  ENDMETHOD.

  METHOD set_fcat.
    IF iv_screenno EQ 1.
      CLEAR gt_fcat.
      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name = 'ZKO_EGT_S_ALVPROGCOUNT'
        CHANGING
          ct_fieldcat      = gt_fcat.

      LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
        IF <gfs_fcat>-fieldname EQ 'PROG_COUNT'.
          <gfs_fcat>-hotspot = abap_true.
        ENDIF.
      ENDLOOP.
    ELSEIF iv_screenno EQ 2.
      CLEAR gt_fcat.
      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name = 'ZKO_EGT_S_ALVPROGDETAIL'
        CHANGING
          ct_fieldcat      = gt_fcat.
    ENDIF.
  ENDMETHOD.

  METHOD set_layout.
    gs_layout-zebra = abap_true.
    gs_layout-cwidht_opt = abap_true.
    gs_layout-col_opt = abap_true.
  ENDMETHOD.
ENDCLASS.
