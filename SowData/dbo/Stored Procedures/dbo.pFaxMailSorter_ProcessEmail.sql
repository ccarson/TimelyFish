
--***********************************************
--Author: Dave Killion
--Created: 9/22/2008
--Used by the method ProcessEmail in the form
--form1 in the project FaxMailSorter
--This ia linked stored procedure to EARTH.CentralData
--***********************************************

CREATE procedure [dbo].[pFaxMailSorter_ProcessEmail] 
      -- Add the parameters for the stored procedure here
      @PhoneNbr as varchar(10)
   

AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
Select 
      f.FarmID, 
      CONVERT(INT, f.ContactID) as  ContactID, 
      p.PhoneNbr 
FROM 
      cfv_FarmSetup f 
      JOIN [$(CentralData)].dbo.ContactPhone cp on CONVERT(INT, f.ContactID) = cp.ContactID and cp.PhoneTypeID = 7 -- removed the earth reference 20130905 smr (saturn retirement)
      JOIN [$(CentralData)].dbo.Phone p on cp.PhoneID = p.PhoneID  -- removed the earth reference 20130905 smr (saturn retirement)
WHERE p.PhoneNbr = @PhoneNbr AND f.Status = 'A'

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pFaxMailSorter_ProcessEmail] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pFaxMailSorter_ProcessEmail] TO [se\analysts]
    AS [dbo];

