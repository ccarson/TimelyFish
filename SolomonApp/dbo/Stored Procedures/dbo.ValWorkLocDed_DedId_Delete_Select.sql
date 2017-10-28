 Create Proc  ValWorkLocDed_DedId_Delete_Select @parm1 varchar ( 10), @parm2 varchar (4) as
       if NOT exists (select DedId from Deduction where DedId = @parm1 and CalYr <> @parm2)
           Delete ValWorkLocDed from ValWorkLocDed Where DedId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ValWorkLocDed_DedId_Delete_Select] TO [MSDSL]
    AS [dbo];

