 Create Proc  ValWorkLocDed_DedId @parm1 varchar ( 10) as
       Select * from ValWorkLocDed
           where DedId  LIKE  @parm1
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ValWorkLocDed_DedId] TO [MSDSL]
    AS [dbo];

