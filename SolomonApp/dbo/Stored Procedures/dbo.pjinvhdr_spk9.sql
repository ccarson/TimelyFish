 Create Procedure pjinvhdr_spk9   as
select * from pjinvhdr where draft_num = 'Z'
order by draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk9] TO [MSDSL]
    AS [dbo];

