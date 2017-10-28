
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

CREATE PROCEDURE cfpPigGroupCpny_PigGroupID 
	@PigGroupID varchar(10)
	AS 
	SELECT CpnyID, PigGroupID FROM cftPigGroup 
	WHERE PigGroupID = @PigGroupID


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpPigGroupCpny_PigGroupID] TO [MSDSL]
    AS [dbo];

