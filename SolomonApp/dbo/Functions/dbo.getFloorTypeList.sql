
CREATE FUNCTION dbo.getFloorTypeList(@DestPigGroupID char(10))
RETURNS VARCHAR(8000) AS

BEGIN
	DECLARE @FloorTypeList varchar(8000)

	SELECT @FloorTypeList = COALESCE(@FloorTypeList + ', ', '') + isnull(cast(bc.floortype as varchar),'NA')
	from cftpmtransprecord tr
	left join cftpiggroup sg on  (sg.piggroupid = tr.sourcepiggroupid)
	left join centraldata.dbo.Barn bn on (sg.sitecontactID = bn.contactID and sg.barnnbr=bn.barnnbr)
	left join centraldata.dbo.BarnChar bc on (bn.barnId= bc.barnID)
	where tr.DestPigGroupID = @DestPigGroupID
	group by bc.floortype

   RETURN @FloorTypeList
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getFloorTypeList] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getFloorTypeList] TO [MSDSL]
    AS [dbo];

