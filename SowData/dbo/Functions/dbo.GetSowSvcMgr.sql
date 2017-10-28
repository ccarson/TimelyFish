CREATE FUNCTION [dbo].[GetSowSvcMgr] 
     (@InputFarmID varchar(8), @InputDate as smalldatetime)  
RETURNS varchar(20)
AS
	BEGIN 
		DECLARE @SvcManager varchar(30)
		SET @SvcManager = IsNull((Select Left(c.ContactFirstName,1) + c.ContactLastName 
					From [$(CentralData)].dbo.Contact c		-- removed the earth reference 20130905 smr (saturn retirement)
					JOIN FarmSvcMgrAssignment f ON c.ContactID = f.ContactID
					WHERE f.FarmID = @InputFarmID 
					AND EffectiveDate = (Select Max(EffectiveDate) From FarmSvcMgrAssignment
								WHERE FarmID = @InputFarmID AND EffectiveDate <=@InputDate)),'NotSpecified')
		RETURN @SvcManager
	END
