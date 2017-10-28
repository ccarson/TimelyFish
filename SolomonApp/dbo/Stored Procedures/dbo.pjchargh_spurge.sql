 Create Procedure pjchargh_spurge @parm1 varchar (06) as
select * from pjchargh
where pjchargh.fiscalno <= @parm1 and batch_status = 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjchargh_spurge] TO [MSDSL]
    AS [dbo];

