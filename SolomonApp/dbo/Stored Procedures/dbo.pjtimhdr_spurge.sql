 Create Procedure pjtimhdr_spurge @parm1 smalldatetime as
select * from pjtimhdr
where pjtimhdr.th_date <= @parm1 and th_status = 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjtimhdr_spurge] TO [MSDSL]
    AS [dbo];

