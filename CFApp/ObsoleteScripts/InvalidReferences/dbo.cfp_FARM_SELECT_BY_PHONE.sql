-- =============================================
-- Author:        ddahle
-- Create date: 3/4/2015
-- Description:   moved from sow data
-- =============================================
create procedure [dbo].[cfp_FARM_SELECT_BY_PHONE]
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
            JOIN [$(CentralData)].dbo.ContactPhone cp on f.ContactID = cp.ContactID	
                   and cp.PhoneTypeID = @PHONE_TYPE
            JOIN [$(CentralData)].dbo.Phone p on cp.PhoneID = p.PhoneID	
      WHERE p.PhoneNbr = @PHONE_NUMBER
            AND f.Status = 'A'
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FARM_SELECT_BY_PHONE] TO [ApplicationCenter]
    AS [dbo];

