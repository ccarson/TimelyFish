
/****** Object:  Stored Procedure dbo.pCFGroupPre    Script Date: 9/3/2004 4:45:59 PM ******/

/****** Object:  Stored Procedure dbo.pCFGroupPre    Script Date: 8/28/2004 9:30:19 AM ******/
--*************************************************************
--	Purpose:Retrieve Task Prefix
--	Author: Sue Matter	
--	Date: 8/4/2004
--	Usage: Pig Group Creation 
--	Parms:
--*************************************************************

CREATE PROCEDURE dbo.pCFGroupPre
AS
Select *
From cftPGSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCFGroupPre] TO [MSDSL]
    AS [dbo];

