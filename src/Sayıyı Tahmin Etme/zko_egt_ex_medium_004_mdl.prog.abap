MODULE status_0100 OUTPUT.
  go_main->pbo-0100( ).
ENDMODULE.

MODULE user_command_0100 INPUT.
  go_main->pai_0100 ( iv_ucomm = sy_ucomm ).
ENDMODULE.
