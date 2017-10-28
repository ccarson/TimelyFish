 Create proc SOHeader_Status_Custid @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 15) as
          Select * from SOHeader where custid = @parm1
          and CpnyId = @parm2
          and ordnbr like @parm3
          and Status = "O"
          order by Ordnbr


