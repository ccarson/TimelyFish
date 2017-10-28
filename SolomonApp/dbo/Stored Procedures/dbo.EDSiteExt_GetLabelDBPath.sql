 Create Proc EDSiteExt_GetLabelDBPath @SiteId varchar(10) As
Declare @LabelDBPath varchar(255)
Select @LabelDBPath = LabelDBPath From EDSiteExt Where SiteId = @SiteId
If LTrim(RTrim(@LabelDBPath)) = ''
  Select @LabelDBPath = LabelDBPath From ANSetup
Select @LabelDBPath



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSiteExt_GetLabelDBPath] TO [MSDSL]
    AS [dbo];

