 Create procedure pjexpdet_srecon @parm1 varchar (10)   as
select * from pjexpdet D, pjexphdr H
where  d.docnbr = h.docnbr and
h.employee = @parm1
order by d.docnbr, d.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjexpdet_srecon] TO [MSDSL]
    AS [dbo];

