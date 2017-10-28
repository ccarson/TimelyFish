 /****** Object:  Stored Procedure dbo.PIDetail_Invtid    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_Invtid @parm1 VarChar(10) As
    select * from pidetail
    where piid = @parm1
    order by piid, invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_Invtid] TO [MSDSL]
    AS [dbo];

