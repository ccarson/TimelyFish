 create procedure  PJ_INVEN_ustat @parm1 varchar (1) , @parm2 varchar (30)   as
update PJ_INVEN
set status_pa = @parm1
where prim_key =  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_INVEN_ustat] TO [MSDSL]
    AS [dbo];

