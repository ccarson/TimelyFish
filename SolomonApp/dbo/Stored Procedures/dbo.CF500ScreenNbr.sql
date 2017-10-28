CREATE PROC [dbo].[CF500ScreenNbr]
	(@parm1 as varchar(8))
	--*************************************************************
	--	Purpose:PV for Pig Account Screens
	--		
	--	Author: Charity Anderson
	--	Date: 2/24/2005
	--	Usage: 
	--	Parms: ScrnNbr
	--*************************************************************

	-- Added Execute As to handle SL Integrated Security method -- TJones 3/13/2012
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

AS
	Select * from SolomonSystem.dbo.Screen where Module='XP' and ScreenType='S' and Number like @parm1 order by Number

