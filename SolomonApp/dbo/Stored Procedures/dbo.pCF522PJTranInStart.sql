



CREATE        PROCEDURE pCF522PJTranInStart
		  @parm1 varchar(10)

	AS
	Select p.* from pjtran p
	JOIN pjptdsum pj ON p.pjt_entity=pj.pjt_entity AND p.acct = pj.acct
	Where (p.acct='PIG TRANSFER IN' OR p.acct='PIG PURCHASE') 
	AND pj.act_amount > 0 
	AND p.pjt_entity= @parm1 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522PJTranInStart] TO [MSDSL]
    AS [dbo];

