 create procedure PJREVHDR_sunpco @parm1 varchar (16) , @parm2 varchar (16)  as
SELECT  *    from PJREVHDR
WHERE       project = @parm1 and
change_order_num = @parm2 and
status <> 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVHDR_sunpco] TO [MSDSL]
    AS [dbo];

