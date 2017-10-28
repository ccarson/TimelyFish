 CREATE PROCEDURE FCWORouting_RtgStep_Descr
	@WONbr		varchar( 16 ),
	@Task		varchar( 32 ),
	@RtgStep	varchar( 5 )
AS

	Select		left(rtrim(R.WorkCenterID) + ': ' + rtrim(W.Descr) + ', ' +
			rtrim(R.OperationID) + ': ' + rtrim(O.Descr) + Space(100),100)
	From		WORouting R (NoLock) Left Outer Join Operation O (NoLock)
			On R.OperationID = O.OperationID
			Left Outer Join WorkCenter W (NoLock)
			On R.WorkCenterID = W.WorkCenterID
	Where		R.WONbr = @WONbr
			and R.Task = @Task
			and R.StepNbr = Cast(@RtgStep As varchar)


