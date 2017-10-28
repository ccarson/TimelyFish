
/****** Object:  Stored Procedure dbo.pCFNewPigGroup    Script Date: 8/28/2004 9:30:19 AM ******/
--*************************************************************
--	Purpose:Retrieve last Task
--	Author: Sue Matter	
--	Date: 8/4/2004
--	Usage: Pig Group Creation 
--	Parms:
--*************************************************************

Create  PROCEDURE dbo.pCFNewPigGroup
AS
Select LastTaskNbr
From cftPGSetup




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCFNewPigGroup] TO [MSDSL]
    AS [dbo];

