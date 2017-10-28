 Create Proc  UnionDeduct_UnionCd_All @parm1 varchar (10) as
       Select * from UnionDeduct
               where Union_Cd  like @parm1
            Order by Union_Cd, DedId, Labor_Class_Cd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionDeduct_UnionCd_All] TO [MSDSL]
    AS [dbo];

