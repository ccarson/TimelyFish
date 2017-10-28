
 /****** Object:  Stored Procedure dbo.FindLastAPCheck    Script Date: 4/7/98 12:19:55 PM ******/
CREATE Procedure [dbo].[FindLastAPCheck] @parm1 varchar ( 10), @parm2 varchar ( 24) As
Select ISNULL(MAX(Convert(Char (10), Convert(integer, refnbr))) ,'0')
FROM APDoc a (NOLOCK)
Where a.DocClass = 'C'
AND a.Acct = @parm1
AND a.Sub = @parm2
AND
(a.DocType in ('CK', 'MC', 'SC', 'ZC')
OR
((a.DocType = 'VC')
 AND NOT EXISTS (SELECT 1 FROM APDoc b (NOLOCK) WHERE a.refnbr = b.refnbr AND a.VendId = b.VendId and a.Acct = b.Acct and a.Sub = b.Sub and (b.DocType = 'HC' or b.DocType = 'EP'))))



