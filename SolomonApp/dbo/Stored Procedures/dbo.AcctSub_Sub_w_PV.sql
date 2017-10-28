
CREATE PROCEDURE dbo.AcctSub_Sub_w_PV
        @CpnyID VarChar ( 10),
        @Acct VarChar ( 10), 

        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN
                                SELECT COUNT(Sub) FROM vs_AcctSub
                                WHERE CpnyID LIKE @CpnyID AND 
                                      Active = 1 AND
                                      Acct LIKE @Acct 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(Sub) FROM vs_AcctSub 
                                      WHERE (CpnyID = '" + @CpnyID + "' AND 
                                             Active = 1 AND 
                                             Acct LIKE '" + @Acct + "') AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " Sub, Acct, Descr FROM vs_AcctSub
                                      WHERE  CpnyID = '" + @CpnyID + "' AND 
                                             Active = 1 AND 
                                             Acct LIKE '" + @Acct + "' 
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN

                                EXEC("SELECT TOP " + @Max + " Sub, Acct, Descr FROM vs_AcctSub 
                                      WHERE (CpnyID = '" + @CpnyID + "' AND 
                                             Active = 1 AND 
                                             Acct LIKE '" + @Acct + "') AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctSub_Sub_w_PV] TO [MSDSL]
    AS [dbo];

