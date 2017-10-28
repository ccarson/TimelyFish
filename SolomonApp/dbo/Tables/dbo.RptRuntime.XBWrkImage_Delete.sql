Create TRIGGER XBWrkImage_Delete
--To remove work record storing image data for check printing
On RPTRuntime For Delete
AS
Begin
	Set NoCount on
	Delete From
		XBWrkImage
	From XBWrkImage X
	Join Deleted D On X.RI_ID = D.RI_ID
	Set NoCount off
End
