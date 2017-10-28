--*************************************************************
--	Purpose:Find duplicate PMTransport Record
--	Author: Charity Anderson
--	Date: 1/10/2005
--	Usage: PigTransportRecord app 
--	Parms:PMLoadID(1), TranDate(2),SourceProject(3), SourceTask(4),SourceQty(5),
--		SubTypeID(6),DestProject(7), DestTask(8), DestQty(9)
--*************************************************************

CREATE PROC dbo.pCF507Duplicate
	@parm1 as varchar(6), 
	@parm2 as smalldatetime,
	@parm3 as varchar(16),
	@parm4 as varchar(32),
	@parm5 as smallint,
	@parm6 as varchar(2),
	@parm7 as varchar(16),
	@parm8 as varchar(32),
	@parm9 as smallint
AS
	Select * from cftPMTranspRecord where 
	PMID=@parm1 and MovementDate=@parm2 and SourceProject=@parm3 and SourceTask=@parm4
	and SourceFarmQty=@parm5 and SubTypeID=@parm6 and DestProject=@parm7 
	and DestTask=@parm8 and DestFarmQty=@parm9
	ORder by RefNbr DESC

 