 Create Procedure pjinvdet_spk5 @parm1 varchar (16), @parm2 varchar (10) as
select * from PJINVDET
where
pjinvdet.Project_Billwith = @parm1 and
pjinvdet.draft_num =      @parm2
and li_type = 'T'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk5] TO [MSDSL]
    AS [dbo];

