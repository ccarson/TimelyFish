-- =============================================
-- Author:	Brain Cesafsky
-- Create date: 7/16/2007
-- Description:	
-- =============================================
CREATE procedure [dbo].[FARM_SELECT_BY_PHONE]
(
	@PHONE_NUMBER nvarchar(10),
	@PHONE_TYPE int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select f.FarmID, f.ContactID, f.Status, p.PhoneNbr
	FROM FarmSetup f
		JOIN [$(CentralData)].dbo.ContactPhone cp on f.ContactID = cp.ContactID -- removed the earth reference 20130905 smr per the saturn retirement
			 and cp.PhoneTypeID = @PHONE_TYPE
		JOIN [$(CentralData)].dbo.Phone p on cp.PhoneID = p.PhoneID -- removed the earth reference 20130905 smr per the saturn retirement
	WHERE p.PhoneNbr = @PHONE_NUMBER
		AND f.Status = 'A'
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FARM_SELECT_BY_PHONE] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[FARM_SELECT_BY_PHONE] TO [se\analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FARM_SELECT_BY_PHONE] TO [MyFaxService]
    AS [dbo];

