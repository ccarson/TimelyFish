 Create Procedure pjinvhdr_sproj @parm1 varchar (16)  as
select * from pjinvhdr where
pjinvhdr.project_billwith = @parm1
order by invoice_date, invoice_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_sproj] TO [MSDSL]
    AS [dbo];

