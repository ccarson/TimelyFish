
CREATE PROCEDURE dbo.Subacct_Sub_Active_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(sub) FROM Subacct WHERE (Active = 1)
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(sub) FROM Subacct 
                                      WHERE (Active = 1) AND " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + " sub, descr  
				from Subacct
                           	where Active = 1 
                              ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " sub, descr   
					from Subacct
                        	WHERE (Active = 1) AND 
                                     " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Sub_Active_w_PV] TO [MSDSL]
    AS [dbo];

