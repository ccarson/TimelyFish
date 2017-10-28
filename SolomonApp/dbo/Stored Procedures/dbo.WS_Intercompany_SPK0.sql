
create procedure WS_Intercompany_SPK0 @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (2), @parm4 varchar (7)
      WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
SELECT FromAcct, FromSub, ToAcct, ToSub, FromCompany, ToCompany 
  FROM vs_Intercompany
 WHERE FromCompany = @parm1 AND
       ToCompany = @parm2 AND
       (Module = @parm3 OR Module = '**') AND
       (Screen = @parm4 OR Screen = 'ALL')
 ORDER BY screen desc, module desc

