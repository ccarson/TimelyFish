

CREATE   Procedure pXF101_OrderStatus
		@parm1 As varchar(1)
As
Select *
From cftOrderStatus
Where Status=@parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF101_OrderStatus] TO [MSDSL]
    AS [dbo];

