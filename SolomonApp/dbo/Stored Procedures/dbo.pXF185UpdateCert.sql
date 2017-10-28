CREATE PROC pXF185UpdateCert 
	(@parm1 varchar(8), @parm2 varchar(10), @parm3 smalldatetime, @parm4 smalldatetime, @parm5 varchar(10))

AS
	--*************************************************************
	--	Purpose:Update Bin Certification
	--	Author: Sue Matter
	--	Date: 4/27/2006
	--	Usage: Feed Delivery  
	--	Parms:Lupd_Prog, Lupd_User, Lupd_DateTime, WithdrawalDate, FeedOrder
	--*************************************************************
Update 
cftBinCert  
Set Lupd_Prog=@parm1, Lupd_User=@parm2, Lupd_DateTime=@parm3, WithdrawalDate=@parm4
where FeedOrdNbr=@parm5


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185UpdateCert] TO [MSDSL]
    AS [dbo];

