 Create Proc  PayGroup_PayGrpId @parm1 varchar ( 6) as
       Select * from PayGroup
           where PayGrpId like @parm1
           order by PayGrpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PayGroup_PayGrpId] TO [MSDSL]
    AS [dbo];

