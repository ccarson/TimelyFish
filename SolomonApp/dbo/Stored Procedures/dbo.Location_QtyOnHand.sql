 /****** Object:  Stored Procedure dbo.Location_QtyOnHand    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_QtyOnHand    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_QtyOnHand as
        Select * from Location where QtyOnHand < 0.00
            order by QtyOnHand



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_QtyOnHand] TO [MSDSL]
    AS [dbo];

