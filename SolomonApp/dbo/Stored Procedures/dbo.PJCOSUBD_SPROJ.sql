 create procedure PJCOSUBD_SPROJ  @parm1 varchar (16)  as
select * from PJCOSUBD
where project       =    @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOSUBD_SPROJ] TO [MSDSL]
    AS [dbo];

