Create proc INPrjAllocationLot_Delete @RefNbr varchar(15), @SrcType varchar (3),  @LineRef varchar(5), @LotSerNbr Varchar(25), @CpnyID varchar (10)  as
Delete From INPrjAllocationLot 
   where  SrcNbr = @RefNbr AND
          SrcType = @SrcType AND
          SrcLineref = @LineRef AND
          LotSerNbr = @LotSerNbr AND 	
          CpnyID = @CpnyID

