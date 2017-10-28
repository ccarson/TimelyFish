 /****** Object:  Stored Procedure dbo.CATran_PerEnt_PerPost    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure CATran_PerEnt_PerPost @parm1 varchar ( 6), @parm2 varchar ( 6) As
        Select * from CATran
        where (PerPost = @parm1
        or PerEnt = @parm2)
        and Rlsed =  1
        order by Perent



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_PerEnt_PerPost] TO [MSDSL]
    AS [dbo];

