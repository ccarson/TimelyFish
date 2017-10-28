 Create Procedure PJEXPHDR_sapp @Parm1 varchar (10) , @Parm2 varchar (1), @parm3 varchar(10), @parm4 varchar(1), @parm5 varchar(100)  
   WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
Select *
From PJEXPHDR
	left outer join PJEMPLOY
		on pjexphdr.employee = pjemploy.employee
Where
	pjexphdr.approver = @parm1 and
	(pjexphdr.status_1 = @parm2 or pjexphdr.status_1 = @parm4) and
	pjexphdr.cpnyid_home like @parm3 and 
	pjexphdr.cpnyid_home in (select cpnyid from dbo.UserAccessCpny(@parm5))
Order by
	pjexphdr.report_date,
	pjexphdr.employee,
	pjexphdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPHDR_sapp] TO [MSDSL]
    AS [dbo];

