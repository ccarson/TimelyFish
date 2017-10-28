 Create Procedure pjinvhdr_spk2 @parm1 varchar (16)  as
select * from pjinvhdr where
project_billwith = @parm1 AND
inv_status <>  'PO'
order by draft_num Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk2] TO [MSDSL]
    AS [dbo];

