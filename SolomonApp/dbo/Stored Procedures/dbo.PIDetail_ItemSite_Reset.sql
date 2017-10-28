 /****** Object:  Stored Procedure dbo.PIDetail_ItemSite_Reset    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_ItemSite_Reset @parm1 VarChar(10) as
    Update itemsite set itemsite.countstatus = 'A'
    From itemsite, pidetail
    Where pidetail.piid = @parm1
    and itemsite.countstatus = 'P'
    and itemsite.siteid = pidetail.siteid
    and itemsite.invtid = pidetail.invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_ItemSite_Reset] TO [MSDSL]
    AS [dbo];

