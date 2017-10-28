 create procedure PJADDR_DPROJ @parm1 varchar (48)   as
delete from PJADDR
where PJADDR.Addr_Key =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJADDR_DPROJ] TO [MSDSL]
    AS [dbo];

