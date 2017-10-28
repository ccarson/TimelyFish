--*************************************************************
--	Purpose:Calculate Live Wgt Yield for Pig Sale
--	Author: Charity Anderson
--	Date: 10/28/2004
--	Usage: Pig Sales Entry		 
--	Parms: PigGroupID,CW,SaleDate
--*************************************************************

CREATE PROC dbo.pCF518PSLiveWgt
	(@parm1 as varchar(10),  @parm3 as smalldatetime )
AS
Declare @Gender as char(6), @theMonth as smallint, @Yield as float
Set @theMonth=cast(DatePart(m,@parm3) as smallint)
Set @Gender=(Select PigGenderTypeID from cftPigGroup where PigGroupID=@parm1)
Set @Yield=(Select Yield from cftLWYield where PigGenderTypeID=@gender and effMonth=@themonth)

Select Yield=@Yield

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518PSLiveWgt] TO [MSDSL]
    AS [dbo];

