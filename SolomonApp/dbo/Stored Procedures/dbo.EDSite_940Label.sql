 CREATE Procedure EDSite_940Label @SiteId varchar(10) As
Select SiteId, LabelCapable From EDSite Where SiteId = @SiteId And Trans = '940'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_940Label] TO [MSDSL]
    AS [dbo];

