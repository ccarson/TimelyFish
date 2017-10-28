 CREATE PROCEDURE CancelShippersWS @parm1 VARCHAR(15), @parm2 VARCHAR(10), @parm3 smallint, @parm4 varchar(7), @parm5 varchar(4), @parm6 varchar(21), @parm7 varchar(10), @parm8 varchar(8), @parm9 smallint
as
/*
 @parm1 - OrdNbr
 @parm2 - CpnyID
 @parm3 - RecCount
 @parm4 - FunctionID
 @parm5 - FunctionClass
 @parm6 - ComputerName
 @parm7 - user
 @parm8 - program
 @parm9 - CPSOn
*/
SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW


--Declare variables for CancelShip Cursor
Declare @ShipperID CHAR(15), @CpnyID CHAR (10)

DECLARE CancelShip_Csr INSENSITIVE CURSOR FOR
SELECT s.ShipperID, s.CpnyID
  FROM SOShipHeader s
 WHERE s.CpnyID = @parm2 
   AND s.OrdNbr = @parm1
   AND s.Status = 'O'
   AND s.Cancelled = 0    
 ORDER BY ShipperID

OPEN CancelShip_Csr
FETCH CancelShip_Csr INTO @ShipperID, @CpnyID
IF @@ERROR <> 0
BEGIN
    CLOSE CancelShip_Csr
    DEALLOCATE CancelShip_Csr
    GOTO ABORT
END
-- For each Shipper, close the shipper.
WHILE @@FETCH_STATUS = 0
BEGIN
  UPDATE s
     SET s.Cancelled = 1, s.DateCancelled = getdate(), 
         s.Status = CASE WHEN @parm3 = 0 THEN 'C' ELSE s.Status END,
         s.NextFunctionID = CASE WHEN @parm3 <> 0 THEN @parm4 ELSE s.NextFunctionID END,
         s.NextFunctionClass = CASE WHEN @parm3 <> 0 THEN @parm5 ELSE s.NextFunctionClass END,
         s.Lupd_DateTime = GETDATE(),
         s.LUpd_Prog = @parm8, 
         s.LUpd_User = @parm7
    FROM SOShipHeader s
   WHERE s.ShipperID = @ShipperID
     AND s.CpnyID = @CpnyID

  IF @@ERROR <> 0
  BEGIN
    CLOSE CancelShip_Csr
    DEALLOCATE CancelShip_Csr
    GOTO ABORT
  END

  If @parm3 = 0 
  BEGIN
        INSERT ProcessQueue (ComputerName, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, 
                             LUpd_Prog, LUpd_User, MaintMode, ProcessCPSOff, ProcessPriority,  
                             ProcessType, SOShipperID, SOShipperLineRef)
        VALUES
        (@parm6, @CpnyID, GETDATE(), @parm8, @parm7, GETDATE(), 
                             @parm8, @parm7, 0, @parm9, 250, 
                             'PLNSH', @ShipperID, '')  
                             
        INSERT ProcessQueue (ComputerName, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, 
                             LUpd_Prog, LUpd_User, MaintMode, ProcessCPSOff, ProcessPriority,  
                             ProcessType, SOShipperID, SOShipperLineRef)
        VALUES
        (@parm6, @CpnyID, GETDATE(), @parm8, @parm7, GETDATE(), 
                             @parm8, @parm7, 0, @parm9, 255, 
                             'PRCSH', @ShipperID, '')                                  
  END

  -- get next record, if any, and loop.
  FETCH CancelShip_Csr INTO  @ShipperID, @CpnyID
  IF @@ERROR <> 0
  BEGIN
    CLOSE CancelShip_Csr
    DEALLOCATE CancelShip_Csr
    GOTO ABORT
  END

END
CLOSE CancelShip_Csr
DEALLOCATE CancelShip_Csr

ABORT:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CancelShippersWS] TO [MSDSL]
    AS [dbo];

