
/****** Object:  Stored Procedure dbo.pCF514BatRelXfer    Script Date: 9/22/2004 8:53:52 AM ******/

CREATE     Proc pCF514BatRelXfer
	  @parm1 varchar (10)
AS
	Select *
	From cftPGInvXfer xf 
	WHERE xf.BatNbr = @parm1
	
