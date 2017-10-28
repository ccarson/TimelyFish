 /****** Object:  Stored Procedure dbo.PIDetail_Whseloc    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_Whseloc @parm1 VarChar(10) As
    select * from pidetail
    where piid = @parm1
    order by piid, whseloc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_Whseloc] TO [MSDSL]
    AS [dbo];

