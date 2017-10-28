 Create Proc Warehouse_Location_DBNAV
   @Parm1 Char(30),
   @Parm2 Char(10),
   @Parm3 Char(10)
as
Select * from Location
   Where InvtID like @Parm1
     and SiteID Like @Parm2
     and WhseLoc Like @Parm3
   Order By InvtId, SiteId, WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Warehouse_Location_DBNAV] TO [MSDSL]
    AS [dbo];

