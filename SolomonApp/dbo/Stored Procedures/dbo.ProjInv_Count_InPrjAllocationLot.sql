
CREATE Proc ProjInv_Count_InPrjAllocationLot
       @Batnbr VarChar(10),
       @LineRef VarChar(5),
       @RecordID Integer


AS

   SELECT COUNT(*)  
     FROM INTran i JOIN INPrjAllocationLot a  
                     ON i.ShipperID = a.SrcNbr  
                    AND a.SrcType = 'SH'  
    WHERE i.Batnbr = @Batnbr  
      AND i.LineRef = @LineRef  
      AND i.RecordID = @RecordID 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Count_InPrjAllocationLot] TO [MSDSL]
    AS [dbo];

