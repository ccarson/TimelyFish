
CREATE PROCEDURE dbo.APDoc_QCPP_RefNbr_w_PV
	@UserID varchar(10),
        @SortCol varchar(60), 
        @Filter varchar(255) , 
        @GetCount char(1) , 
        @Max char(5) AS

	IF @GetCount = 'Y'
	  BEGIN
		IF @Filter  = ''
			BEGIN

				SELECT COUNT(RefNbr) FROM APDoc 
                                WHERE DocClass = 'N' AND 
                                     (APDoc.DocType IN ('VO','AC','AD')) AND 
                                      Status <> 'V' AND Crtd_User = @UserID
			END
		ELSE
			BEGIN
				EXEC("SELECT COUNT(RefNbr) FROM APDoc 
                                      WHERE (DocClass = 'N' AND 
                                            (APDoc.DocType IN ('VO','AC','AD'))AND 
                                             Status <> 'V')  AND Crtd_User = '"+@UserID+"' AND  
                                             " + @Filter)
			END		
	  END

	ELSE

	  BEGIN

		IF @Filter  = '' 

		   BEGIN

			EXEC("SELECT TOP " + @Max + " RefNbr, InvcNbr, VendId, DocBal  
                              FROM APDoc 
                              WHERE DocClass = 'N' AND 
                                   (APDoc.DocType IN ('VO','AC','AD')) AND 
                                    Status <> 'V' AND Crtd_User = '"+@UserID+"'
                              ORDER BY " + @SortCol )
		   END

		ELSE

		   BEGIN

			EXEC("SELECT TOP " + @Max + " RefNbr, InvcNbr, VendId, DocBal  
                              FROM APDoc 
                              WHERE (DocClass = 'N'AND 
                                    (APDoc.DocType IN ('VO','AC','AD')) AND 
                                     Status <> 'V') AND Crtd_User = '"+@UserID+"' AND 
                                     " + @Filter +" 
                              ORDER BY " + @SortCol )
		END
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_QCPP_RefNbr_w_PV] TO [MSDSL]
    AS [dbo];

