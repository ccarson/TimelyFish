create procedure dbo.cfp_PigGroupSummary
@GroupID varchar(10)
as

select cast(StartWgt as float) StartWgt from cfv_PigGroupSummary WHERE GroupID = @GroupID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PigGroupSummary] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_PigGroupSummary] TO [MSDSL]
    AS [dbo];

