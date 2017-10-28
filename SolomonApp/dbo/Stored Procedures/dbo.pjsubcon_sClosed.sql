 Create Procedure pjsubcon_sClosed @parm1 varchar (16)  as
select * from pjsubcon
where    pjsubcon.project          =    @parm1
and      not pjsubcon.status_sub IN ('C','D',' ')
order by
project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjsubcon_sClosed] TO [MSDSL]
    AS [dbo];

