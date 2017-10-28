 Create Procedure pjinvdet_si30 @parm1 varchar (16) , @parm2 varchar (32)  as
select sum(amount), pjinvdet.project from pjinvdet
Where
pjinvdet.project = @PARM1 and
pjinvdet.pjt_entity = @PARM2 and
pjinvdet.li_type = 'I' and
pjinvdet.hold_status <> 'PG' and
(pjinvdet.bill_status = 'U' or pjinvdet.bill_status = 'S')
Group by pjinvdet.project
order by pjinvdet.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_si30] TO [MSDSL]
    AS [dbo];

