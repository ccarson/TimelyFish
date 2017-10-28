
--*************************************************************
--	Purpose: Farm Permission Maintenance PV 
--	Author: Doran Dahle
--	Date: 4/20/2012
--	Usage: Farm Permission Maintenance			 
--	Parms: UserID
--*************************************************************

CREATE   PROCEDURE [dbo].[pXF103_UserId]
   	@UserId varchar(47)
   	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
 AS 
 Select * from SolomonSystem.dbo.UserRec Where RecType='U' AND UserId Like @UserId Order by UserID
 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF103_UserId] TO [MSDSL]
    AS [dbo];

