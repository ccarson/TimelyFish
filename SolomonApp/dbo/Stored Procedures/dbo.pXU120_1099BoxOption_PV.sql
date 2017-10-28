CREATE PROCEDURE pXU120_1099BoxOption_PV (@Parm1 varchar(2))
	AS	
	--------------------------------------------------------------------------------------------------------
	-- PURPOSE:		This procedure is utilized as a PV related procedure to provide a list of options 
	--				for the 1099 box field in the custom screen for importing AP vouchers. 
	-- CREATED BY:	Boyer & Associates, Inc. (TJones)
	-- CREATED ON:	2/13/2013
	--------------------------------------------------------------------------------------------------------
	SELECT BoxNbr, BoxDescr 
	FROM cfv1099BoxOption 
	WHERE BoxNbr LIKE @Parm1
	ORDER BY BoxOrder

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU120_1099BoxOption_PV] TO [MSDSL]
    AS [dbo];

