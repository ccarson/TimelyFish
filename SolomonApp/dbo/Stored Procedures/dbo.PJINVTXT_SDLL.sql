 create procedure PJINVTXT_SDLL  @parm1 varchar (10) , @parm2 varchar (1)   as
select z_text from PJINVTXT
where    draft_num  = @parm1
and    text_type  = @parm2
order by draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINVTXT_SDLL] TO [MSDSL]
    AS [dbo];

