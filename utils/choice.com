�2YN                                                                                                                                Waits for the user to choose one of a set of choices.

 CHOICE [/C[:]choices] [/N] [/S] [/T[:]c,nn] [text]

 /C[:]choices Specifies allowable keys. Default is YN
/N           Do not display choices and ? at end of prompt string.
/S           Treat choice keys as case sensitive.
/T[:]c,nn    Default choice to c after nn seconds
text         Prompt string to display

ERRORLEVEL is set to offset of key user presses in choices.

 Invalid switch on command line. Expected form:
     CHOICE: invalid choice switch syntax. Expected form: /C[:]choices
 CHOICE: Incorrect timeout syntax.  Expected form Tc,nn or T:c,nn
 CHOICE: Timeout default not in specified (or default) choices.
 CHOICE: only one prompt string allowed. Expected Form:
     CHOICE: requires MS-DOS version 4.0 or later.
                                                                                                                                            ���0�!<�y�W���N�e���� ���/�!G�=&�� +ã3���>/�1�� �<u�8</tA< t�<	t쿯�= u <"u�"��/��<t�:�t�F��</t�F�Ļ<�������������<?t$<Ct7<Ntm<Ttq<Su�� �?���������������������<:uF�< t<	t<t
</t�F��� ���t�A��t�^���U�� �.��<:uF�<tN</tJ< tF<	tB��F�<,u8F�<0r1<9w-����F�<0s���<9v������
 ����â�F������� ���� ������>�t���� ����< t
��� �F���� ���t��� ��� ��� �>�u)���[�!���!G�= t��,�!���]�!��?�!�>� t-�,�!�6���!���� u�,�!86�t�6���u࠮���!��>�t�E �= t�t
�����!�ݴ���!���!��
�!���ǴL�!PWR�3���� t�!G��Z_X�SW<ar<zw, �<�r�>/��2�+3&�_[�