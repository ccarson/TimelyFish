Create Proc [dbo].[UpdateBPReportCatalog] @parm1 varchar (256) as

    -- Check to see if the ReportCatalog table exists in this DB
    if exists (select * from dbo.sysobjects where id = object_id('dbo.ReportCatalog') and sysstat & 0xf = 3) 
    Begin
        -- If it does then check to see if a record exists based on the parameter sent in
        -- If the record exists, then update the published date to today
        if @parm1 <> ''
        Begin
            Update ReportCatalog set Last_Date_Published = GETDATE(), 
            Last_Time_Published = GetDate() where Report_URL = @parm1
        End
    End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateBPReportCatalog] TO [MSDSL]
    AS [dbo];

