



-- =============================================
-- Author:		Doran Dahle
-- Create date: 10/29/2014
-- Description:	This procedure creates the primary dataset for the Transport Load Weight Report
--	            in the Transportation folder.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_LOAD_Wgt]
	@ReportDate Datetime = Null,
	@PigType Varchar(30)

AS
BEGIN
SET NOCOUNT ON;
SELECT [PMLoadID]
      ,[MovementDate]
      ,[comment]
      ,[PigType]
      ,[Flow]
      ,[Origin]
      ,[Dest]
      ,[TruckerName]
      ,[GradingCount]
      ,[GrossWgt]
      ,[TareWgt]
      ,[Net]
  FROM [SolomonApp].[dbo].[cfv_PM_SAFE_Wgt]
  where [MovementDate] = Case When @ReportDate = null Then convert(date, getdate()) Else convert(date, @ReportDate) End
	And [PigType] Like Case When lTrim(rTrim(@PigType)) = '' Then '%' Else @PigType End
  order by Flow

END





GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_LOAD_Wgt] TO [MSDSL]
    AS [dbo];

