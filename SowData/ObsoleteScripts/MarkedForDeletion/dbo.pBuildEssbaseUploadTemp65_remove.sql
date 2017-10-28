

CREATE PROC [dbo].[pBuildEssbaseUploadTemp65_remove]
	@FarmID varchar(8)
	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON
	-- Update each of the temporary records with the appropriate division and department (based
	-- upon the effective date being less than or equal to the temporary record's weekofdate
	BEGIN TRANSACTION
	UPDATE t
	SET t.Div = v.Div, t.Dept = v.Dept
	from EssbaseUploadTemp t
	JOIN FarmSetup fs ON t.FarmID = fs.FarmID
	JOIN vSiteDivDept v ON fs.ContactID = v.ContactID 
		AND EffectiveDate = (Select Max(EffectiveDate) 
					FROM vSiteDivDept 
					WHERE ContactID = fs.ContactID
					AND EffectiveDate <= t.WeekOfDate)
	COMMIT WORK
	
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp65_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp65_remove] TO [se\analysts]
    AS [dbo];

