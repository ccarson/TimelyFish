 CREATE PROCEDURE ProjectInventory_PCStatus AS

UPDATE INPrjAllocTranHist 
   SET PC_Status = '2'
 WHERE PC_Status = '1'
   AND TranSrcType IN ('ISS','SHP','RFR')  -- Issue to Project, or Consumed on a Shipper, Return Receipt of Project Inventory


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectInventory_PCStatus] TO [MSDSL]
    AS [dbo];

