 create procedure PJLABHDR_SALL @parm1 varchar (10)   as
select * from PJLABHDR
where    docnbr  LIKE @parm1
order by docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_SALL] TO [MSDSL]
    AS [dbo];

