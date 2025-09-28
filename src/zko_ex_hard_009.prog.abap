*&---------------------------------------------------------------------*
*& Report ZKO_EX_HARD_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zko_ex_hard_009.

INCLUDE: zko_ex_hard_009_top,
         zko_ex_hard_009_cls,
         zko_ex_hard_009_mdl.

START-OF-SELECTION.
  CREATE OBJECT go_main.
  go_main->start_screen( ).
