 /****** Object:  Stored Procedure dbo.Subacct_Count    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc  Subacct_Count as
       Select count(*) from Subacct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Count] TO [MSDSL]
    AS [dbo];

