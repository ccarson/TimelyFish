 CREATE Proc ED850_Purge @CpnyId varchar(10), @CustId varchar(10), @CreatedDateFrom smalldatetime, @CreatedDateTo smalldatetime, @ClosedOrdersOnly smallint AS

-- First select PO's to delete
Select B.EDIPOID Into #EDIPurge From ED850Header A Inner Join ED850HeaderExt B On
A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID Where A.CustId Like @CustId And B.CreationDate >=
@CreatedDateFrom And B.CreationDate <= @CreatedDateTo And A.CpnyId = @CpnyId And A.UpdateStatus
= 'OC'

-- If we are only deleted purchase orders for which all sales orders are closed then delete the
-- edipoids for POs with open sales orders from the temp table.
If @ClosedOrdersOnly = 1
  Delete From #EDIPurge From #EDIPurge A Inner Join SOHeader B On A.EDIPOID = B.EDIPOID Where B.Status <> 'C' And B.Cancelled = 0

-- Now delete from all 850 tables.
Delete From ED850Contact Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850HDisc Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850Header Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850HeaderExt Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850HSSS Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850LDesc Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850LDisc Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850LineItem Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850LRef Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850LSSS Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850MarkFor Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850Sched Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)
Delete From ED850SDQ Where CpnyId = @CpnyId And EDIPOID In (Select EDIPOID From #EDIPurge)

Drop Table #EDIPurge



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850_Purge] TO [MSDSL]
    AS [dbo];

