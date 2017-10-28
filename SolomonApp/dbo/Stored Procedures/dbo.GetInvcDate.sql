 Create Proc GetInvcDate @parm1 varchar (15), @parm2 varchar (10) as
 select min(docdate) from ardoc where custid = @parm1
and doctype = "IN"
and cpnyid like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetInvcDate] TO [MSDSL]
    AS [dbo];

