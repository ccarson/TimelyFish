Create Procedure pa_CF662 @RI_ID smallint as 
	Delete from wrkPFEUInel Where RI_ID = @RI_ID
