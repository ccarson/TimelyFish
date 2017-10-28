
/****** Object:  Stored Procedure dbo.pCF500TranScreen    Script Date: 9/21/2004 2:58:01 PM ******/

/****** Object:  Stored Procedure dbo.pCF500TranScreen    Script Date: 9/9/2004 1:58:57 PM ******/
CREATE   Proc dbo.pCF500TranScreen
	@parm1 varchar(2), 
	@parm2 varchar(10)
AS
	Select *
	From cftPGTTypeScr
	WHERE cftPGTTypeScr.TranTypeID = @parm1 And cftPGTTypeScr.ScreenNbr Like @parm2
	Order by cftPGTTypeScr.TranTypeID, cftPGTTypeScr.ScreenNbr 


