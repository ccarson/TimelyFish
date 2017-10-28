 Create Procedure pjinvdet_sstatus as
select * from pjinvdet
WHERE bill_status IN ('U', 'S')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sstatus] TO [MSDSL]
    AS [dbo];

