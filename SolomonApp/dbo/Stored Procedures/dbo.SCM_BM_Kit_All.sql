 Create Proc SCM_BM_Kit_All @parm1 varchar (30) as
	Select * From Kit Where
		KitId LIKE @parm1 and
		KitType = 'B'
	Order By KitId


