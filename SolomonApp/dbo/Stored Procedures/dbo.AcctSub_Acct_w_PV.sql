CREATE PROCEDURE dbo.AcctSub_Acct_w_PV
        @CpnyID VarChar ( 10),
        @Sub VarChar ( 24),
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(ASub.Acct2) as Acct FROM vs_AcctSubStab ASub, Account A
                                WHERE ASub.CpnyID LIKE @CpnyID and 
                                      ASub.Active = 1 AND
                                      ASub.Sub LIKE @Sub AND
                                      ASub.Acct2 = A.Acct and A.Active <> 0
 
     
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(ASub.Acct2) as Acct FROM vs_AcctSubStab ASub, Account A 
                                      WHERE (ASub.CpnyID = '" + @CpnyID + "' AND 
                                             ASub.Active = 1 AND 
                                             ASub.Sub LIKE '" + @Sub + "' AND
                                      ASub.Acct2 = A.Acct and A.Active <> 0) AND " 
                                            + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " ASub.Acct2 as Acct, ASub.Sub as Sub, ASub.Descr2 as Descr FROM vs_AcctSubStab ASub, Account A
                                      WHERE ASub.CpnyID = '" + @CpnyID + "' AND
                                            ASub.Active = 1 AND
                                            ASub.Sub LIKE '" + @Sub + "'  AND
                                      ASub.Acct2 = A.Acct and A.Active <> 0 
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " ASub.Acct2 as Acct, ASub.Sub as Sub, ASub.Descr2 as Descr FROM vs_AcctSubStab ASub, Account A
                                      WHERE (ASub.CpnyID = '" + @CpnyID + "' AND
                                            ASub.Active = 1 AND
                                            ASub.Sub LIKE '" + @Sub + "'  AND
                                      ASub.Acct2 = A.Acct and A.Active <> 0) AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctSub_Acct_w_PV] TO [MSDSL]
    AS [dbo];

