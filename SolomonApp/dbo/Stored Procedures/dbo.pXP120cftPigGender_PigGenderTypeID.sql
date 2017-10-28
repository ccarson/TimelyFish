CREATE PROC pXP120cftPigGender_PigGenderTypeID
	@GenderTypeID as varchar(6)
	----------------------------------------------------------------
	--	Purpose:DBNav procedure for cftPigGenderType table
	--	Author: TJones
	--	Date: 8/29/2005
	--	Usage: XP120
	--	Parms:PigGenderTypeID
	----------------------------------------------------------------	
	AS
	SELECT * 
	FROM cftPigGenderType
	WHERE PigGenderTypeID LIKE @GenderTypeID
	ORDER BY PigGenderTypeID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP120cftPigGender_PigGenderTypeID] TO [MSDSL]
    AS [dbo];

