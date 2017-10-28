 CREATE PROCEDURE EDSite_PickTicketMeth @SiteId as varchar(10)  AS
-- Returns ConvMeth for Site
Declare @RetVal VarChar(10)
select @RetVal = (Select ConvMeth  from EDSite where SiteId = @SiteId and Trans = '940')
-- If not set up, assume print only
if IsNull(@RetVal,'~') = '~'
   Select @RetVal = 'PPT'
Select @RetVal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_PickTicketMeth] TO [MSDSL]
    AS [dbo];

