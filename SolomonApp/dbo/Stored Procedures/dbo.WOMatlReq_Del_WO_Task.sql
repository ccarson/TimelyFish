 CREATE PROCEDURE WOMatlReq_Del_WO_Task
   @WONbr      varchar( 16 ),
   @Task       varchar( 32 )
AS
   DELETE
   FROM        WOMatlReq
   WHERE       WONbr = @WONbr and
               Task = @Task


