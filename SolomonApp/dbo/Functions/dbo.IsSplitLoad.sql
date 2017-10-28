Create Function [dbo].[IsSplitLoad]
	(@PMLoadID as char(10))
RETURNS bit

AS
BEGIN
DECLARE @IsSplit as bit
DECLARE @ReturnCt as int

select @ReturnCt = count(*) from (select distinct DestContactID from cftPM pm (NOLOCK) where PMLoadID = @PMLoadID) x

IF @ReturnCt > 1
	set @IsSplit = 1
ELSE
	set @IsSplit = 0

RETURN @IsSplit

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsSplitLoad] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[IsSplitLoad] TO [MSDSL]
    AS [dbo];

