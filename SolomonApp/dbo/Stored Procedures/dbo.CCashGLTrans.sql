 /****** Object:  Stored Procedure dbo.CCashGLTrans    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure CCashGLTrans @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 15), @parm4 varchar ( 2), @parm5 varchar( 20) as
    select * from GLtran where
    BatNbr = @parm1
    and Refnbr = @parm2
    and ExtRefNbr = @parm3
    and Module = @parm4
    and ID = @parm5


