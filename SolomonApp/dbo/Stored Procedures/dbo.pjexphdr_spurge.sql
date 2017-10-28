 Create Procedure pjexphdr_spurge @parm1 varchar (06) as
select * from pjexphdr
where pjexphdr.fiscalno <= @parm1 and status_1 = 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjexphdr_spurge] TO [MSDSL]
    AS [dbo];

