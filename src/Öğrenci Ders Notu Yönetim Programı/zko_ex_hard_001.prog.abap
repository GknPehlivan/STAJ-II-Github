REPORT zko_ex_hard_001 MESSAGE-ID ZKO_EX_HRD_001.

INCLUDE: zko_ex_hard_001_top,
         zko_ex_hard_001_cls,
         zko_ex_hard_001_mdl.

START-OF-SELECTION.
  CREATE OBJECT go_main.
  go_main->start_screen( ).
