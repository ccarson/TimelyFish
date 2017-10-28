
CREATE VIEW VS_UnreleasedAPVoidCheck
AS
  SELECT acct, sub, refnbr, 1 as Unrsled 

  from aptran where drcr = 'V'

