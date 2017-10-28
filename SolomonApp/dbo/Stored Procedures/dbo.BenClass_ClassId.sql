 Create Proc  BenClass_ClassId @parm1 varchar ( 10) as
       Select * from BenClass
           where ClassId LIKE @parm1
           order by ClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenClass_ClassId] TO [MSDSL]
    AS [dbo];

