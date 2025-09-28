MODULE status_0100 OUTPUT.
  go_main->pbo_0100( ).
ENDMODULE.

MODULE user_command_0100 INPUT.
  go_main->pai_0100 ( iv_ucomm = sy-ucomm ).
ENDMODULE.

MODULE status_0200 OUTPUT.
  go_main->pbo_0200( ).
ENDMODULE.

MODULE user_command_0200 INPUT.
  go_main->pai_0100 ( iv_ucomm = sy-ucomm ).
ENDMODULE.
