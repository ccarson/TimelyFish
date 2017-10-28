
CREATE PROCEDURE dbo.AcctSub_DB_Acct_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

	SELECT	@Filter = REPLACE(REPLACE(REPLACE(REPLACE(@Filter, '[Sub]', '[ASub].[Sub]'), '[Acct]', '[ASub].[Acct]'), '[CpnyID]', '[ASub].[CpnyID]'), '[Descr]', '[ASub].[Descr]')

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(ASub.Acct) as Acct FROM vs_AcctSub ASub, Account A, vs_Company c
                                WHERE ASub.CpnyID = c.CpnyID AND 
                                      ASub.Active = 1 AND
                                      c.DatabaseName = DB_NAME() AND
                                      ASub.Acct = A.Acct and A.Active <> 0
 
     
                        END
                ELSE
                        BEGIN
                                EXEC('SELECT COUNT(ASub.Acct)as Acct FROM vs_AcctSub ASub, Account A, vs_Company c 
                                      WHERE (ASub.CpnyID = c.CpnyID AND 
                                             ASub.Active = 1 AND 
                                             c.DatabaseName = DB_NAME() AND
                                      ASub.Acct = A.Acct and A.Active <> 0) AND (' 
                                            + @Filter + ')')
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC('SELECT TOP ' + @Max + ' ASub.Acct as Acct, ASub.Sub as Sub, ASub.CpnyID as CpnyID, ASub.Descr as Descr FROM vs_AcctSub ASub, Account A, vs_Company c 
                                      WHERE ASub.CpnyID = c.CpnyID AND 
                                            ASub.Active = 1 AND
                                            c.DatabaseName = DB_NAME() AND
                                      ASub.Acct = A.Acct and A.Active <> 0 
                                      ORDER BY ' + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC('SELECT TOP ' + @Max + ' ASub.Acct as Acct, ASub.Sub as Sub, ASub.CpnyID as CpnyID, ASub.Descr as Descr FROM vs_AcctSub ASub, Account A, vs_Company c 
                                      WHERE (ASub.CpnyID = c.CpnyID AND 
                                            ASub.Active = 1 AND
                                            c.DatabaseName = DB_NAME() AND
                                      ASub.Acct = A.Acct and A.Active <> 0) AND (' 
                                            + @Filter + ') 
                                      ORDER BY ' + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctSub_DB_Acct_w_PV] TO [MSDSL]
    AS [dbo];

