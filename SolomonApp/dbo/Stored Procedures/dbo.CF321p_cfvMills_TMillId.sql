Create Procedure CF321p_cfvMills_TMillId @parm1 varchar (6) as 
    Select * from cfvMills Where MillId Like @parm1 and Exists (Select * from cftTMVendor Where 
	MillId = cfvMills.MillId)
	Order by MillId
