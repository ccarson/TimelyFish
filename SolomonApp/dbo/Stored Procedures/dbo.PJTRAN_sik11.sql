 create procedure PJTRAN_sik11 @parm1 varchar (16) , @parm2 varchar (6) , @parm3 smalldatetime   as
select * from PJTRAN
where
project = @parm1 and
fiscalNo = @parm2 and
trans_date <= @parm3 and
batch_type <> 'ALLC' and
alloc_flag  =  ' '



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sik11] TO [MSDSL]
    AS [dbo];

