 /****** Object:  Stored Procedure dbo.LotSerMst_ALL    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerMst_ALL    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerMst_Serial_QtyRemain @parm1 varchar ( 30), @parm2 varchar (25) as
     SELECT * 
       FROM LotSerMst 
      WHERE InvtId = @parm1
        AND LotSerNbr = @parm2
        AND QtyOnHand > 0
      ORDER BY InvtId, Siteid, Whseloc, LotSerNbr


