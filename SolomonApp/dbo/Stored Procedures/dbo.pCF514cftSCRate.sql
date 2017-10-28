
/****** Object:  Stored Procedure dbo.pCF514cftSCRate    Script Date: 2/4/2005 2:46:35 PM ******/

CREATE    Proc pCF514cftSCRate
         @parm1 varchar (16), @parm2 varchar(16)
as
	Select *
	From cftSCRate
	WHERE Type='PRODUCTION PHASE'
	AND SubType = @parm1
	AND AcctCat = @parm2



