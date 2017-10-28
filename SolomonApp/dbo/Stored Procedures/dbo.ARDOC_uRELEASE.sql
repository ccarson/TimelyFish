 create procedure ARDOC_uRELEASE @parm1 varchar (10) as
update ARDOC set rlsed=1
where batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_uRELEASE] TO [MSDSL]
    AS [dbo];

