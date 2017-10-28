 /****** Object:  Stored Procedure dbo.PIDetCost_Delete_CX    Script Date: 10/13/2000 ******/
Create Procedure PIDetCost_Delete_CX
	@PerClosed VarChar(6)
As
    Delete From PIDetCost
	From	PIHeader
	Where	PIHeader.PIID = PIDetCost.PIID
		And PIHeader.Status In ('C', 'X')
		And PIHeader.PerClosed <= @PerClosed



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetCost_Delete_CX] TO [MSDSL]
    AS [dbo];

