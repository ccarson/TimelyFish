-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date,,>
-- Description:   <Description,,>
-- =============================================
CREATE procedure [dbo].[cfs_FARM_SELECT_BY_PHONE]
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
            JOIN [$(CentralData)].dbo.ContactPhone cp on f.ContactID = cp.ContactID	-- remove the earth reference 20130905 smr 
                   and cp.PhoneTypeID = @PHONE_TYPE
            JOIN [$(CentralData)].dbo.Phone p on cp.PhoneID = p.PhoneID	-- remove the earth reference 20130905 smr 
      WHERE p.PhoneNbr = @PHONE_NUMBER
            AND f.Status = 'A'
END

GRANT EXECUTE on [dbo].[cfs_FARM_SELECT_BY_PHONE] to [SQLEssbaseSproc]

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_FARM_SELECT_BY_PHONE] TO [SQLEssbaseSproc]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_FARM_SELECT_BY_PHONE] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfs_FARM_SELECT_BY_PHONE] TO [se\analysts]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfs_FARM_SELECT_BY_PHONE] TO [MyFaxService]
    AS [dbo];

