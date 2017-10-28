 Create Procedure pjinvdet_sunbill2 @parm1 varchar (16)  as
select  pjinvdet.source_trx_date,
pjinvdet.amount,
pjinvdet.project_billwith
From    pjinvdet
Where
pjinvdet.project_billwith = @PARM1 and
pjinvdet.draft_num = ''  and
pjinvdet.hold_status <> 'PG'
order by
pjinvdet.source_trx_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sunbill2] TO [MSDSL]
    AS [dbo];

