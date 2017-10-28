--*************************************************************
--	Purpose:DBNav for Pig Account Screens
--		
--	Author: Charity Anderson
--	Date: 2/24/2005
--	Usage: 
--	Parms: acct,ScrnNbr
--*************************************************************

CREATE PROC dbo.CF500PigAcctScrn
	(@parm1 as varchar(16), @parm2 as varchar(8))
AS
Select * from cftPigAcctScrn where acct=@parm1 and ScrnNbr like @parm2 order by ScrnNbr
