 Create Proc  RptCompany_Insert @parm1 smallint, @parm2 varchar (10), @parm3 varchar (30) as
INSERT INTO RptCompany (RI_ID, CpnyID, CpnyName, tstamp)
VALUES (@parm1, @parm2, @parm3, NULL)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptCompany_Insert] TO [MSDSL]
    AS [dbo];

