 create procedure PJREVHDR_spostco @parm1 varchar (16) , @parm2 varchar (16)  as
SELECT  *    from PJREVHDR
WHERE       project = @parm1 and
change_order_num = @parm2 and
status = 'P'


