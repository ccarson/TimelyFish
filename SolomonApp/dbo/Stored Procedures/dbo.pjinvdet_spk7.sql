 Create Procedure pjinvdet_spk7 @parm1 varchar (10)  as
select * from PJINVDET
where pjinvdet.draft_num =      @parm1
and li_type in ( 'T', 'R' )



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk7] TO [MSDSL]
    AS [dbo];

