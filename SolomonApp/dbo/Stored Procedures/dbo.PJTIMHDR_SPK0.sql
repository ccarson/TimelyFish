 create procedure PJTIMHDR_SPK0 @parm1 varchar (10)  as
select * from PJTIMHDR
where    docnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMHDR_SPK0] TO [MSDSL]
    AS [dbo];

