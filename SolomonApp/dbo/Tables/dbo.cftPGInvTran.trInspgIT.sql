
-- =============================================
-- Author:	sripley
-- Create date: 11/27/2012
-- Description:	update CF12 with the calc 
-- update: 12/12/2011 sripley -- insert will update the CF12 column.
-- =============================================


CREATE TRIGGER [dbo].[trInspgIT] ON [dbo].[cftPGInvTran] 
FOR INSERT
AS
Set nocount on
BEGIN TRAN


update cftpginvtran
set cf12 = 
case
      when d.qty > 0 then d.totalwgt/d.qty
      else 0
end
FROM cftPGInvTran a
JOIN Inserted d on 
a.batnbr=d.batnbr and a.module = d.module and a.linenbr = d.linenbr


COMMIT TRAN 

set nocount off




