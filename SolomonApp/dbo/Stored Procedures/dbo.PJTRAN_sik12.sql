 create procedure PJTRAN_sik12 @parm1 varchar (16) , @parm2 smalldatetime , @parm3 smalldatetime    as
select * from PJTRAN
where
        project = @parm1 and
        alloc_flag <> 'X'   and
        trans_date >= @parm2 and
        trans_date <= @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sik12] TO [MSDSL]
    AS [dbo];

