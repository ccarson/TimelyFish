 Create Procedure pjinvtxt_spk0 @parm1 varchar (10)  as
select * from  pjinvtxt where
draft_num = @parm1 AND
text_type = 'I'
order by draft_num, text_type, project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvtxt_spk0] TO [MSDSL]
    AS [dbo];

