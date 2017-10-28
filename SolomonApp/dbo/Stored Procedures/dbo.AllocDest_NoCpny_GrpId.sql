 /****** Object:  Stored Procedure dbo.AllocDest_NoCpny_GrpId    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AllocDest_NoCpny_GrpId @parm1 varchar ( 6), @parm2 varchar ( 10), @parm3 varchar ( 24) as
       Select * from AllocDest
           where GrpId =    @parm1
             and Acct  like @parm2
             and Sub   like @parm3
           order by GrpId, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AllocDest_NoCpny_GrpId] TO [MSDSL]
    AS [dbo];

