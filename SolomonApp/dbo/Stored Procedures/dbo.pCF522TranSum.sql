
/****** Object:  Stored Procedure dbo.pCF522TranSum    Script Date: 11/4/2004 4:43:31 PM ******/

CREATE  PROCEDURE pCF522TranSum
		  @parm1 varchar(16),
		  @parm2 varchar(32),
		  @parm3 varchar(16)

	AS
	SELECT pj.Project, pj.pjt_entity, sum(pj.act_amount) As TotQty
	from PJPTDSUM pj
	JOIN PJACCT ac On pj.acct=ac.acct
	Where ac.acct_type='EX' AND pj.Project=@parm1 AND pj.pjt_entity=@parm2 AND pj.Acct<>@parm3
	Group by pj.Project, pj.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522TranSum] TO [MSDSL]
    AS [dbo];

