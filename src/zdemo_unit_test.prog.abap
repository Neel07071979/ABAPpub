*&---------------------------------------------------------------------*
*& Report ZDEMO_UNIT_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_UNIT_TEST.

PARAMETERS: p_num TYPE i.

DATA(lv_num_1) = p_num.

"1st form covered by UT
PERFORM multiply_by_two CHANGING p_num.

WRITE: / |{ lv_num_1 } X 2 is { p_num }.|.

DATA(lv_num_2) = p_num.

"2nd form not covered by UT
PERFORM add_two CHANGING p_num.

WRITE: / |{ lv_num_1 } + 2 is { p_num }.|.

"======================
" FORM
"======================
FORM multiply_by_two CHANGING num TYPE i.
  num = num * 2.
ENDFORM.

FORM add_two CHANGING num TYPE i.
  num = num + 2.
ENDFORM.


"================
" UNIT TEST
"================
CLASS ltc_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
 PRIVATE SECTION.
  METHODS test_multiple_two FOR TESTING.
 ENDCLASS.

 CLASS ltc_test IMPLEMENTATION.
   METHOD test_multiple_two.
    DATA: testnum TYPE i VALUE 2.

    PERFORM multiply_by_two CHANGING testnum.

    cl_abap_unit_assert=>assert_equals( act = testnum
                                        exp = 4
                                        msg = 'multiply_two does not return the correct number ( should by multiplied by 2)' ).
    ENDMETHOD.
   ENDCLASS.
