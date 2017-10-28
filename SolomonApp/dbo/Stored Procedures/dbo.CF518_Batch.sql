--*************************************************************
--	Purpose:PigSales Batch PV
--	Author: Charity Anderson
--	Date: 11/10/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-05-02  Doran Dahle Changed screen filter to XP518 from CF518.
						

===============================================================================
*/
CREATE PROC [dbo].[CF518_Batch]
	(@parm1 as varchar(10))
AS
Select * from Batch where BatNbr like @parm1 and Crtd_Prog ='XP518' order by BatNbr DESC
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF518_Batch] TO [MSDSL]
    AS [dbo];

