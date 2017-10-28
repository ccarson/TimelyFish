 Create Procedure pjinvhdr_invc @parm1 varchar(10) as
select * from pjinvhdr where invoice_num like @parm1
order by invoice_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_invc] TO [MSDSL]
    AS [dbo];

