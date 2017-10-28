

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_HAT_HTP_SCHEDULE_SITE] 
	@Site	varchar(1000)

AS
BEGIN
    IF CHARINDEX('%', @Site) > 0 
   	     Select * from dbo.cfv_HAT_HTP_Schedule
	      Where Active_cde = 'A'
	   order by site asc, LAB
    ELSE
       Select * from dbo.cfv_HAT_HTP_Schedule
	      Where Siteid in (select * from SolomonApp.dbo.cffn_SPLIT_STRING( @Site, ',')) and Active_cde = 'A'
	   order by site asc, LAB
END


