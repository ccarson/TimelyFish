
CREATE PROCEDURE dbo.AcctXRef_Acct_w_PV
        @CpnyID varchar (10),
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

  SELECT vs_AcctXRef.* FROM vs_AcctXRef, vs_Company

 
                              SELECT COUNT(vs_AcctXRef.Acct) FROM vs_AcctXRef, vs_Company

                                WHERE vs_Company.CpnyID = @CpnyID AND vs_AcctXRef.CpnyID = vs_Company.CpnyCOA
                                     and  vs_AcctXRef.Active = 1                                

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(vs_AcctXRef.Acct) FROM vs_AcctXRef, vs_Company 
                                      WHERE (vs_Company.CpnyID = '" + @CpnyID + "' AND  vs_AcctXRef.CpnyID = vs_Company.CpnyCOA
                                              AND  vs_AcctXRef.Active = 1) AND " 
                                            + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " vs_AcctXRef.Acct, vs_AcctXRef.Descr FROM vs_AcctXRef , vs_Company
                                      WHERE vs_Company.CpnyID = '" + @CpnyID + "' AND vs_AcctXRef.CpnyID = vs_Company.CpnyCOA AND
                                             vs_AcctXRef.Active = 1
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " vs_AcctXRef.Acct, vs_AcctXRef.Descr FROM vs_AcctXRef , vs_Company 
                                      WHERE (vs_Company.CpnyID =  '" + @CpnyID + "' AND vs_AcctXRef.CpnyID = vs_Company.CpnyCOA AND 
                                              vs_AcctXRef.Active = 1) AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctXRef_Acct_w_PV] TO [MSDSL]
    AS [dbo];

