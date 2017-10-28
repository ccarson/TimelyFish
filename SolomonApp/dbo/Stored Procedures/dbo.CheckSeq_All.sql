 --  ***** 12/14/01 Commented out, Proc will be checked in with SCM code
-- QN 11/12/2001, smTM_Detail_Pricing for Advance Payroll integration
--IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'smTM_Detail_Pricing' AND TYPE = 'P')
--      BEGIN
--              DROP PROCEDURE smTM_Detail_Pricing
--      END
--GO

--CREATE PROCEDURE smTM_Detail_Pricing
--      @szContractID   VARCHAR(10),
--      @szCustID       VARCHAR(15),
--      @szShiptoID     VARCHAR(10),
--      @szInvtID       VARCHAR(30),
--      @UnitCost       MONEY,
--      @UnitPrice      MONEY   OUTPUT
--AS
--
--DECLARE @StkBasePrc   MONEY
--
--      SELECT @UnitPrice = 0.00
--
--      -- temporary, just return stock base price
--      SELECT @StkBasePrc = StkBasePrc
--      FROM INVENTORY (NOLOCK)
--      WHERE InvtID = @szInvtID
--
--      IF @@ERROR = 0
--      BEGIN
--              SELECT @UnitPrice = @StkBasePrc
--      END
--
--RETURN
--
-- GO

--  ***** 12/14/01 Commented out, Proc will be checked in with SCM code
--Create Proc PRDetail_Pricing @szServCallID VARCHAR(10),@szCustID VARCHAR(15),@szShiptoID VARCHAR(10),@szInvtID VARCHAR(30),@UnitCost float As
--    Declare @UnitPrice float
--
--    EXECUTE smTM_Detail_Pricing @szServCallID,@szCustID,@szShiptoID,@szInvtID,@UnitCost,@UnitPrice OUTPUT
--
--    Select @UnitPrice
--GO

Create Proc CheckSeq_All
@ChkSeq varchar(2)
AS
SELECT *
FROM CheckSeq
WHERE ChkSeq LIKE @ChkSeq
ORDER BY ChkSeq


