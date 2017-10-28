 Create Proc Kit_Kitid_Status_Siteid_Type @parm1 varchar ( 30), @parm2 varchar (1), @parm3 varchar (10)   as
	Select * from Kit where
	Kitid like @parm1
	and Status like @parm2
	and Siteid like @parm3
	and KitType = 'B'
	Order by Kitid,Status,Siteid


