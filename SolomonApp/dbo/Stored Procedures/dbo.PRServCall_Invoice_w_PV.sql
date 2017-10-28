
CREATE PROCEDURE dbo.PRServCall_Invoice_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(ServiceCallId) FROM smServCall  
                                WHERE cmbInvoiceType = 'T' and 
					ServiceCallCompleted = 0 and 
					ServiceCallStatus = 'R' 

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(ServiceCallId) FROM smServCall  
                                      WHERE (cmbInvoiceType = 'T' and 
					ServiceCallCompleted = 0 and 
					ServiceCallStatus = 'R'  AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC ("SELECT TOP " + @Max + " ServiceCallId, CpnyID, ServiceCallStatus, CustomerId FROM smServCall 
                                      WHERE  cmbInvoiceType = 'T' and 
					ServiceCallCompleted = 0 and 
					ServiceCallStatus = 'R'   
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " ServiceCallId, CpnyID, ServiceCallStatus, CustomerId FROM smServCall 
                                      WHERE (cmbInvoiceType = 'T' and 
					ServiceCallCompleted = 0 and 
					ServiceCallStatus = 'R' AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRServCall_Invoice_w_PV] TO [MSDSL]
    AS [dbo];

