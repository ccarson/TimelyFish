
Create Proc PFT_Check as
IF exists (select * from dbo.sysobjects where id = object_id('dbo.XRPSETUP') and sysstat & 0xf = 3) 
	Select 1
ELSE
	Select 0
