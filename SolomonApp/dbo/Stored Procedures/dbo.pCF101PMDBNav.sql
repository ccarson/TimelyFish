--*************************************************************
--	Purpose:DBNav for PigMovement Wean Detail
--		
--	Author: Charity Anderson
--	Date: 2/1/2005
--	Usage: FlowBoardModule, WeanEntry	 
--	Parms: Month,Year,ContactID,System,IDMin,IDMax,LineNbrMin, LineNbrMax,
--*************************************************************

CREATE PROC dbo.pCF101PMDBNav
	(@parm1 as smallint,
	 @parm2 as smallint,
	 @parm3 as varchar(10),
	 @parm4 as varchar(2),
	 @parm5 as varchar(10),
	 @parm6 as varchar(10),
	 @parm7 as smallint,
	 @parm8 as smallint)
AS
Select * from cftPM 
Where 
PMTypeID='01' and Datepart(month,MovementDate)=@parm1 and Datepart(year,MovementDate)=@parm2
and SourceContactID=@parm3 and PMSystemID=@parm4 
--and CpnyID=@parm5 
and PigTypeID='02'
--and ID=@parm6
and PMID like @parm6
and LineNbr between @parm7 and @parm8

order by MovementDate,PMID
