 Create Procedure pjinvhdr_sstat as
select * from pjinvhdr where inv_status <> 'PO' and inv_status <> 'PR'
order by draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_sstat] TO [MSDSL]
    AS [dbo];

