 Create Proc Kit_Kitid_Site53 @parm1 varchar ( 30), @parm2 varchar ( 10) as
        Select * from Kit where
        	Kitid like @parm1 and
		Siteid like @parm2 and
		Status <> 'O' and
		KitType = 'B'
        Order by Kitid, Siteid, Status


