Create Procedure CF531p_cftMileageRate_LM @parm1beg smallint, @parm1end smallint as 
    Select * from cftMileageRate Where LowMiles Between @parm1beg and @parm1end
	Order by LowMiles
