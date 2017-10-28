
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE pXU010PigGroupCpny_PigGroupID 
	-- CREATED BY: TJones
	-- CREATED ON: 5/20/05
	@PigGroupID varchar(10)
	AS 
	SELECT CpnyID, PigGroupID FROM cftPigGroup 
	WHERE PigGroupID = @PigGroupID

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010PigGroupCpny_PigGroupID] TO [MSDSL]
    AS [dbo];

