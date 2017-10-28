--*************************************************************
--	Purpose:Barns with more than one PayLean bin
--	Author: Charity Anderson
--	Date: 1/4/2004
--	Usage:Feed Order Exceptions XF150	 
--	Parms: @parm1   -display results
--*************************************************************

CREATE PROC dbo.pXF150PayLean (@parm1 as smallint)
	
AS
IF @parm1=1 
BEGIN
Select  f.BarnNbr,f.BinNbr , f.ContactID ,c.ContactName,Max(DateOrd) as LastOrdered,
f.RoomNbr
FROM dbo.cftFeedOrder f 
JOIN
	(SELECT     BarnNbr,ContactId,cast(RoomNbr as char(10)) as RoomNbr, COUNT(BinNbr) AS Expr1
	FROM          
		(Select Distinct f.BarnNbr,f.BinNbr,f.ContactID,f.RoomNbr,bt.Description 
			from dbo.cftFeedOrder f 
			JOIN cftInvtPaylean pl
			
			on (f.InvtIDOrd=pl.InvtId or f.InvtIDDel=pl.InvtID)
			LEFT JOIN cftBin bin on f.BinNbr=bin.BinNbr and f.ContactID=bin.ContactID
			LEFT JOIN cftBinType bt on bin.BinTypeID=bt.BinTypeID 
			where Status<>'C' and User8=0 and rtrim(bt.Description)<>'Single' ) do
	GROUP BY BarnNbr,ContactId,RoomNbr
	HAVING      (COUNT(BinNbr) > 1)) dup 
ON f.ContactId = dup.ContactId 
AND f.BarnNbr = dup.BarnNbr 
AND f.RoomNbr = dup.RoomNbr
and f.Status<>'C' and User8=0
LEFT JOIN cftContact c on f.ContactID=c.ContactID
JOIN cftInvtPaylean pl on (f.InvtIDOrd=pl.InvtId or f.InvtIDDel=pl.InvtID)


Group by f.BarnNbr ,f.BinNbr ,f.ContactID ,c.ContactName,
f.RoomNbr
Order by c.ContactName,f.BarnNbr, f.RoomNbr,f.BinNbr
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF150PayLean] TO [MSDSL]
    AS [dbo];

