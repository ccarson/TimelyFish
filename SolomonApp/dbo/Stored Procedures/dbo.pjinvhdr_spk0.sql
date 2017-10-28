 Create Procedure pjinvhdr_spk0 @parm1 varchar (10)  as
select * from pjinvhdr where draft_num = @parm1
order by draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk0] TO [MSDSL]
    AS [dbo];

