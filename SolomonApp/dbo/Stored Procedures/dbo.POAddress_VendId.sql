 /****** Object:  Stored Procedure dbo.POAddress_VendId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure POAddress_VendId @parm1 varchar ( 15), @parm2 varchar ( 10) as
Select * from POAddress where VendId = @parm1
and OrdFromId like @parm2
Order by VendId, OrdFromId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POAddress_VendId] TO [MSDSL]
    AS [dbo];

