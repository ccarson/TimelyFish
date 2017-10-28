
Create Procedure dbo.pUnAssignSite
	@Parent varchar(20),
	@ContactID varchar(5),
	@EffectiveDate smalldatetime
AS
BEGIN

UPDATE SiteBioSecurity
	Set ProductionPhaseBioSecurityLevelID=NULL
	WHERE EffectiveDate=@EffectiveDate
	AND ContactID like @ContactID
	
INSERT INTO SiteBioSecurity
	Select @EffectiveDate,ContactID,Null
	FROM (Select Max(EffectiveDate) as EffectiveDate,ContactID From SiteBioSecurity
		WHERE EffectiveDate<@EffectiveDate
		AND ProductionPhaseBioSecurityLevelID=@Parent
		AND ContactID like @ContactID
		GROUP BY ContactID,ProductionPhaseBioSecurityLevelID) derived
END
