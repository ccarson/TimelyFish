 create procedure PJCOMDET_spk0 @parm1 varchar (2)   as
select * from PJCOMDET
where    system_cd like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMDET_spk0] TO [MSDSL]
    AS [dbo];

