 Create procedure PJJNTHDR_SALL_MC  @parm1 varchar (15), @parm2 varchar(100), @parm3 varchar (16)  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJJNTHDR.* from PJJNTHDR 
		Inner Join PJPROJ 
			ON PJPROJ.project = PJJNTHDR.project
where    vendid     LIKE  @parm1 
	AND pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2))
	AND PJJNTHDR.project    LIKE  @parm3
order by PJJNTHDR.vendid, PJJNTHDR.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJJNTHDR_SALL_MC] TO [MSDSL]
    AS [dbo];

