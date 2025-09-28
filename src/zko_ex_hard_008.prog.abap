*&---------------------------------------------------------------------*
*& Report ZKO_EX_HARD_008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZKO_EX_HARD_008.

INCLUDE: zko_ex_hard_008_top,
         zko_ex_hard_008_cls,
         zko_ex_hard_008_mdl.

START-OF-SELECTION.
  CREATE OBJECT go_main.
  go_main->start_screen( ).
