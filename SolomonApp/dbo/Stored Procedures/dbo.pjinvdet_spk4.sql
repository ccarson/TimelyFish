 Create Procedure pjinvdet_spk4 @parm1 varchar (10)  as
select * from PJINVDET
where pjinvdet.draft_num =      @parm1
order by pjinvdet.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk4] TO [MSDSL]
    AS [dbo];

