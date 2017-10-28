
--*************************************************************
--	Purpose:Update the weekly average Market Value for Tailender Transfers
--	Author: Sue Matter
--	Date: 12/26/2005
--	Usage: PigTransportRecord 
--	Parms: 
--	      
--*************************************************************


CREATE Procedure pCF522UpdateAvg 
AS 
BEGIN
--get the average
Update cftPigMktValue Set MktAvg=
(Select Sum(MktAct) From cftPigMktValue where WkDet=v.WkDet)/(Select Count(MktAct) from cftPigMktValue Where MktAct<>0 and WkDet=v.WkDet)
From cftPigMktValue v
Where v.MktAct<>0
END

BEGIN
--update averages for dates without actuals for the same week
Update cftPigMktValue 
Set MktAvg= ISNULL((Select Top 1(MktAvg) from cftPigMktValue Where WkDet=v.WkDet AND MktAvg<>0),0)
From cftPigMktValue v
Where v.MktAvg=0 AND v.MktAct=0
 
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pCF522UpdateAvg] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522UpdateAvg] TO [MSDSL]
    AS [dbo];

