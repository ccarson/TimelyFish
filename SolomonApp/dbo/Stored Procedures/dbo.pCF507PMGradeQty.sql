--*************************************************************
--	Purpose:DBNav for GradeQty Level			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: BatchNbr, RefNbr, PM

--*************************************************************
Create Procedure pCF507PMGradeQty 
	@parm1 varchar (10),
	@parm2 varchar (10),
	@parm3mn smallint,
	@parm3mx smallint
As
Select pmg.*,grt.* ,sub.*
From cftPMGradeQty pmg
LEFT join cftPigGradeCatType grt on pmg.PigGradeCatTypeID=grt.PigGradeCatTypeID
LEFT JOIN cftPigGradeSubType sub on pmg.PigGradeSubCatTypeID=sub.PigGradeSubTypeID
Where pmg.BatchNbr=@parm1 and pmg.RefNbr=@parm2 and pmg.LineNbr between @parm3mn and @parm3mx 
Order By pmg.BatchNbr, pmg.RefNbr 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF507PMGradeQty] TO [MSDSL]
    AS [dbo];

