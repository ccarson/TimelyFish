
CREATE PROCEDURE dbo.Account_Active_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(acct) FROM Account WHERE (Active <> 0)
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(acct) FROM Account 
                                      WHERE (Active <> 0) AND " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + " acct,descr,acct_cat 
				from Account
                           	where Active <> 0 
                              ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " acct,descr,acct_cat  
					from Account
                        	WHERE (Active <> 0) AND 
                                     " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Account_Active_w_PV] TO [MSDSL]
    AS [dbo];

