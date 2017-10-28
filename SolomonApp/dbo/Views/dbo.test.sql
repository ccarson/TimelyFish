CREATE VIEW dbo.test
AS
SELECT     dbo.cftPigSale.*, RefNbr AS Expr1
FROM         dbo.cftPigSale
WHERE     (RefNbr = '170942') OR
                      (RefNbr = '170943') OR
                      (RefNbr = '170944') OR
                      (RefNbr = '170945') OR
                      (RefNbr = '170798') OR
                      (RefNbr = '170799') OR
                      (RefNbr = '170800') OR
                      (RefNbr = '170802')
