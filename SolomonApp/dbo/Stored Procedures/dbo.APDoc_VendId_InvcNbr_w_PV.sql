
CREATE PROCEDURE dbo.APDoc_VendId_InvcNbr_w_PV
	@VendID varchar(15),
	@InvcNbr varchar(15),
	@RefNbr varchar(10),
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(refnbr) FROM APDOc WHERE (VendID =  @VendID and InvcNbr = @InvcNbr
					and Status <> 'V' and RefNbr <> @RefNbr)
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(refnbr) FROM APDOc WHERE (VendID = '"+ @VendID+"' and InvcNbr = '"+ @InvcNbr+"'
					and Status <> 'V' and RefNbr <> '"+ @RefNbr+"')" + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + "refnbr, docdate, doctype, invcnbr, perent, vendid, origdocamt from
				APDOc WHERE (VendID =  '"+ @VendID+"' and InvcNbr = '"+ @InvcNbr+"'
					and Status <> 'V' and RefNbr <> '"+ @RefNbr+"')
                              ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + "refnbr, docdate, doctype, invcnbr, perent, vendid, origdocamt from
				APDOc WHERE (VendID =  '"+ @VendID+"' and InvcNbr = '"+ @InvcNbr+"'
					and Status <> 'V' and RefNbr <> '"+ @RefNbr+"') AND 
                                     " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_VendId_InvcNbr_w_PV] TO [MSDSL]
    AS [dbo];

