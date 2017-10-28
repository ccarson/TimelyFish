 /****** Object:  Stored Procedure dbo.PIHeader_Balanced    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIHeader_Balanced @parm1 varchar(10) As
    select * from piheader
    where piid like @parm1 and status = 'B'
    order by piid desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIHeader_Balanced] TO [MSDSL]
    AS [dbo];

