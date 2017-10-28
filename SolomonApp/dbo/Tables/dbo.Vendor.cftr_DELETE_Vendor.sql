
-- =============================================
-- Author:		Matt Dawson
-- Create date: 12/9/2008
-- Description:	replicate data over to cfapp_cornpurch
-- =============================================
CREATE TRIGGER [dbo].[cftr_DELETE_Vendor]
   ON  [dbo].[Vendor]
with execute as '07718158D19D4f5f9D23B55DBF5DF1'
   FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

DELETE cft_Vendor
FROM CFApp_CornPurch.dbo.cft_Vendor cft_Vendor, Deleted d
WHERE RTRIM(cft_Vendor.VendID) = RTRIM(d.VendID)


END

