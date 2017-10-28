 Create Procedure PJEXPHDR_scompany @parm1  varchar (1), @parm2 varchar(10), @parm3  varchar (1),  @parm4 varchar(100)   
   WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
Select *
From PJEXPHDR
	left outer join PJEMPLOY
		on	pjexphdr.employee = pjemploy.employee
Where
	(pjexphdr.status_1 = @parm1 or pjexphdr.status_1 = @parm3) and
	pjexphdr.cpnyid_home like @parm2 and
	pjexphdr.cpnyid_home in (select cpnyid from dbo.UserAccessCpny(@parm4))
Order by
	pjexphdr.report_date,
	pjexphdr.employee,
	pjexphdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPHDR_scompany] TO [MSDSL]
    AS [dbo];

