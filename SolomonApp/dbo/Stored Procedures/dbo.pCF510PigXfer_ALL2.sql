
/****** Object:  Stored Procedure dbo.pCF510PigXfer_ALL2    Script Date: 1/25/2005 3:26:43 PM ******/

/****** Object:  Stored Procedure dbo.pCF510PigXfer_ALL2    Script Date: 1/20/2005 5:32:51 PM ******/

/****** Object:  Stored Procedure dbo.pCF510PigXfer_ALL2    Script Date: 9/15/2004 11:59:49 AM ******/

/****** Object:  Stored Procedure dbo.pCF510PigXfer_ALL2    Script Date: 9/15/2004 11:17:59 AM ******/

/****** Object:  Stored Procedure dbo.pCF510PigXfer_ALL2    Script Date: 8/28/2004 11:16:27 AM ******/
CREATE  Procedure pCF510PigXfer_ALL2 
	@parm1 varchar (10),
	@parm2min smallint,
	@parm2max smallint
As
Select *
From cftPGInvXfer as A
LEFT JOIN cftPGInvTType B on A.TranTypeID=B.TranTypeID
LEFT JOIN cftPGInvTSub C on A.TranTypeID=C.TranTypeID AND A.TranSubTypeID=C.SubTypeID
Where A.BatNbr=@parm1 AND A.LineNbr BETWEEN @parm2min AND @parm2max Order By A.BatNbr, A.LineNbr 








GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510PigXfer_ALL2] TO [MSDSL]
    AS [dbo];

