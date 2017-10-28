
CREATE PROCEDURE dbo.Batch_EditScrnNbr_w_PV
	@UserID varchar(10),
        @SortCol varchar(60), 
        @Filter varchar(255) , 
        @GetCount char(1) , 
        @Max char(5) AS

	IF @GetCount = 'Y'
	  BEGIN
		IF @Filter  = ''
			BEGIN

				SELECT COUNT(BatNbr) FROM Batch 
                                WHERE (Batch.EditScrnNbr IN ('58010','VW010')) 
			END
		ELSE
			BEGIN
				EXEC("SELECT COUNT(BatNbr) FROM Batch 
                                      WHERE (Batch.EditScrnNbr IN ('58010','VW010'))
					   AND " + @Filter)
			END		
	  END

	ELSE

	  BEGIN

		IF @Filter  = '' 

		   BEGIN

			EXEC("SELECT TOP " + @Max + " BatNbr, Status, PerPost, PerEnt, CtrlTot
                              FROM Batch 
                              WHERE (Batch.EditScrnNbr IN ('58010','VW010'))
                              ORDER BY " + @SortCol )
		   END

		ELSE

		   BEGIN

			EXEC("SELECT TOP " + @Max + "  BatNbr, Status, PerPost, PerEnt, CtrlTot  
                              FROM Batch 
                              WHERE (Batch.EditScrnNbr IN ('58010','VW010')) AND 
                                     " + @Filter +" 
                              ORDER BY " + @SortCol )
		END
	END

