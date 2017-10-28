CREATE procedure PORTNlot_exists @CpnyID varchar (10), @RcptNbr varchar(15), @LineRef varchar(5)  as

   SET NOCOUNT ON

   SELECT count(*) 
     FROM INPrjAllocationLot l With(NoLock)  
    WHERE l.CpnyID = @CpnyID  
      AND l.SrcNbr = @RcptNbr  
      AND l.SrcLineRef = @LineRef  
      AND l.SrcType = 'RN'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PORTNlot_exists] TO [MSDSL]
    AS [dbo];

