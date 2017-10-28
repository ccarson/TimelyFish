
/****** Object:  Stored Procedure dbo.pXP110_Pods    Script Date: 8/11/2005 9:24:24 AM ******/
CREATE    PROCEDURE pXP110_Pods
	@parm1 varchar(3)
	AS
	Select * 
	from cftPigProdPod 
	Where PodID Like @parm1
	Order by PodID


