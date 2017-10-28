 create procedure earntype_spk0 @parm1 varchar (10)   as
select * from earntype
where id = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[earntype_spk0] TO [MSDSL]
    AS [dbo];

