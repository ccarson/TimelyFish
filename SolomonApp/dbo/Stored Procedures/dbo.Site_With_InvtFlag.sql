 CREATE PROCEDURE Site_With_InvtFlag
	@Parm1 VARCHAR (10),
	@Parm2 VARCHAR (30),
	@Parm3 VARCHAR (30),
    @Parm4 VARCHAR (10)

AS
	SELECT distinct *
	FROM vi_SiteWithInvtFlag v1
	WHERE
		CpnyID = @Parm1 AND
		(InvtID = @Parm2 or
                 (InvtID is null and not exists (select 'x'
                                                   from vi_SiteWithInvtFlag v2
                                                  where v1.CpnyID = v2.CpnyID AND
                                                        v2.InvtID = @Parm3 AND
                                                        v1.SiteID = v2.SiteID
                                                        )
                  )
        ) AND
		SiteID LIKE @Parm4
	ORDER BY SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Site_With_InvtFlag] TO [MSDSL]
    AS [dbo];

