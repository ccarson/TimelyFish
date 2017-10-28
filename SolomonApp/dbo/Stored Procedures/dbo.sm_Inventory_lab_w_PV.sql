
CREATE PROCEDURE dbo.sm_Inventory_lab_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(InvtId) FROM Inventory 
                                WHERE stkitem = 0 

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(InvtId) FROM Inventory 
                                      WHERE stkitem = 0 AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC ("SELECT TOP " + @Max + " InvtID, Descr, ClassID FROM Inventory
                                      WHERE  stkitem = 0  
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " InvtID, Descr, ClassID FROM Inventory
                                      WHERE (stkitem = 0 AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[sm_Inventory_lab_w_PV] TO [MSDSL]
    AS [dbo];

