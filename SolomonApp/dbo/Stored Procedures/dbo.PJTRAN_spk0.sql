 create procedure PJTRAN_spk0 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 varchar (6)    as
select * from PJTRAN
where project =  @parm1 and
pjt_entity  =  @parm2 and
acct = @parm3 and
fiscalno like @parm4
order by post_date, trans_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_spk0] TO [MSDSL]
    AS [dbo];

