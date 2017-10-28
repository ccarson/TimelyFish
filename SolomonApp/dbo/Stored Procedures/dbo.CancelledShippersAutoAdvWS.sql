 CREATE PROCEDURE CancelledShippersAutoAdvWS @parm1 VARCHAR(15), @parm2 VARCHAR(10), @parm3 varchar(7), @parm4 varchar(4)
as
/*
 @parm1 - OrdNbr
 @parm2 - CpnyID
 @parm3 - FunctionID
 @parm4 - FunctionClass
*/
SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

SELECT s.ShipperID, s.CpnyID, s.SOTypeID, s.OrdNbr, s.NextFunctionID, s.NextFunctionClass, s.SiteID, s.AdminHold, s.CreditHold, s.CreditChk, s.ProjectID, s.Status
  FROM SOShipHeader s
 WHERE s.CpnyID = @parm2 
   AND s.OrdNbr = @parm1
   AND s.Status = 'O'
   AND s.Cancelled = 1  
   AND s.NextFunctionID = @parm3
   AND s.NextFunctionClass = @parm4
   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CancelledShippersAutoAdvWS] TO [MSDSL]
    AS [dbo];

