
CREATE PROCEDURE dbo.vendor_all_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(VendID) FROM Vendor 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(VendID) FROM Vendor 
                                      WHERE " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + " VendID, Name, Status, Terms, APAcct,
                                             APSub,  ExpAcct, ExpSub, DfltBox
                                      FROM Vendor
                                      ORDER BY " + @SortCol) 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " VendID, Name, Status, Terms, APAcct,
                                             APSub, ExpAcct, ExpSub, DfltBox
                                      FROM Vendor
                                      WHERE " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vendor_all_w_PV] TO [MSDSL]
    AS [dbo];

