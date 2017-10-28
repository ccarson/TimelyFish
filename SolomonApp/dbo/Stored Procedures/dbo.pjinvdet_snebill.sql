 Create Procedure pjinvdet_snebill @PARM1 varchar (16) as
select * from pjinvdet
Where
project = @PARM1 and
(bill_status <> 'B' and bill_status <> ' ') and hold_status <> 'PG'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_snebill] TO [MSDSL]
    AS [dbo];

