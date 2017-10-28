 /****** Object:  Stored Procedure dbo.PIDetail_NbrAdjustments    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_NbrAdjustments @parm1 VarChar(10) As
select Count(*) from pidetail where piid = @parm1 and bookqty <> physqty and status = 'E'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_NbrAdjustments] TO [MSDSL]
    AS [dbo];

