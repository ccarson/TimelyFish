 create procedure pjinvdet_sProj  @parm1 varchar (16)   as
select * from pjinvdet
where    project     =   @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sProj] TO [MSDSL]
    AS [dbo];

