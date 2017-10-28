 create procedure PJLABHDR_SI01 @parm1 smalldatetime  as
select  Count(*) from PJLABHDR
where   pe_date <=  @parm1 and
le_Status <> 'P' and
le_Status <> 'X' and
le_type = 'R '



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_SI01] TO [MSDSL]
    AS [dbo];

