

-- =============================================
-- Author:	sripley
-- Create date: 11/27/2012
-- Description:	update CF12 with the average weight calculation if either totalwgt or qty change 
-- =============================================
CREATE TRIGGER [dbo].[trUpdPGIT] ON [dbo].[cftPGInvTran] 
FOR UPDATE
AS
Set nocount on
BEGIN TRAN

update cftpginvtran
set cf12 = 
case
      when i.qty > 0 then i.totalwgt/i.qty
      else 0
end
from inserted I (nolock)
	inner join deleted D (nolock) on I.batnbr=d.batnbr and i.module = d.module and i.linenbr= d.linenbr
    inner join cftpginvtran invt (nolock) on I.batnbr=invt.batnbr and i.module = invt.module and i.linenbr= invt.linenbr
  where (I.qty <> D.qty or I.totalwgt <> D.totalwgt)


COMMIT TRAN
set nocount off