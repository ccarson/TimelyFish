 Create Procedure pjinvhdr_spk1 @parm1 varchar (16) , @parm2 varchar (10)  as
	select * from pjinvhdr where
		project_billwith = @parm1 AND
		draft_num Like @parm2
		order by Project_billwith, draft_num Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk1] TO [MSDSL]
    AS [dbo];

