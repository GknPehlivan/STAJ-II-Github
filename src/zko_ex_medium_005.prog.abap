*&---------------------------------------------------------------------*
*& Report ZKO_EX_MEDIUM_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZKO_EX_MEDIUM_005.

INCLUDE: zko_egt_ex_medium_005_top,
         zko_egt_ex_medium_005_mdl,
         zko_egt_ex_medium_005_cls.

START-OF-SELECTION.
  CREATE OBJECT go_main( ).
  go_main->start_screen( ).
