 Create Procedure pjinvdet_spk0 @parm1 int  as
select * from
pjinvdet
Where
source_trx_id = @parm1
order by
source_trx_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk0] TO [MSDSL]
    AS [dbo];

