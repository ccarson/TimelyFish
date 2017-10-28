/****** Object:  Stored Procedure dbo.pCF511StatMnt_pv    Script Date: 8/3/2004 4:37:14 PM ******/

CREATE    Proc dbo.pCF511StatMnt_pv
		@parm1 varchar(2)
	as
	Select * From cftPGStatus
		WHERE PigGroupStatusID LIKE @parm1
	Order by PigGroupStatusID
