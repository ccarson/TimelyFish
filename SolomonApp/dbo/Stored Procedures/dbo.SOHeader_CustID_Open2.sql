 Create proc SOHeader_CustID_Open2 @parm1 varchar ( 15), @parm2 varchar ( 10) as
          Select * from SOHeader where custid = @parm1
          and CpnyId = @parm2
          and Status = "O"
          and UnshippedBalance > 0
          order by Ordnbr


