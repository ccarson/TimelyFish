 create procedure  PJLABHDR_ltexp  @parm1 varchar (6) , @parm2 smalldatetime   as
select * from PJLABHDR, PJLABDIS, PJEMPLOY
where
pjlabhdr.docnbr = pjlabdis.docnbr and
pjlabhdr.le_status in ('P','X') and
pjlabdis.status_1 = ' ' and
pjlabdis.status_2 <> 'P' and
pjlabhdr.employee = pjemploy.employee and
pjlabhdr.fiscalno = @parm1 and
pjlabdis.pe_date <= @parm2
Order by
pjlabhdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_ltexp] TO [MSDSL]
    AS [dbo];

