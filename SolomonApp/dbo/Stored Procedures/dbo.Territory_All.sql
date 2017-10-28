 /****** Object:  Stored Procedure dbo.Territory_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Territory_All @parm1 varchar (10) as
    Select * from Territory where
    Territory like @parm1
    order by Territory



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Territory_All] TO [MSDSL]
    AS [dbo];

