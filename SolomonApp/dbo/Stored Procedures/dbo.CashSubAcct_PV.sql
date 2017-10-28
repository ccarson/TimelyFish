 -- **********************************************************************************************
--
--  WARNING:	 THE FOLLOWING CODE SHOULD NOT BE MODIFIED! CHANGING THIS CODE MAY
--		 RESULT IN CORRUPTED DATA AND INSTABILITY IN APPLICATIONS.
--
--  Copyright:  1999-2002 Solomon Software, Inc.
--              200 E Hardin Street
--              Findlay, OH  45840
--              800-4-SOLOMON
--              www.solomon.com
--
--  Name:       CashSubAcct_PV
--  Inputs:     @Parm1  CompanyID
--  		@Parm2 Bank Account
--		@Parm3 Bank Sub-account
--  Output:     None
--  Called by:  0801000
--  Calling:    None
--  Purpose:    Verify the account exists in the database
--  Version:    4.21.0001
--  Author:     Solomon Software, Inc. - Financial Management Group
--  Comment:    When printing, for best output print in Landscape mode with margin settings of 0.5 inch.
--              Any count value greater than zero means a repetetive TaxIDs on the same line
--
--  History:    Lists History of source asset:
--              2000/06/07 - Original source asset created.
--  *********************************************************************************************
--

Create Proc CashSubAcct_PV @Parm1 VARCHAR ( 10), @Parm2 VARCHAR(10), @Parm3 VARCHAR (24) AS
    SELECT * FROM CashAcct
    WHERE cpnyid   =  @parm1 AND
          bankacct LIKE @parm2 AND
          BankSub  LIKE @Parm3 AND
          Active =  1
    ORDER BY BankAcct, BankSub


