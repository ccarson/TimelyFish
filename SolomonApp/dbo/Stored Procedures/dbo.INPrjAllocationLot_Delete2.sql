Create proc INPrjAllocationLot_Delete2 @RefNbr varchar(15), @SrcType varchar (3), @CpnyID varchar (10)  as
Delete From INPrjAllocationLot 
   where  SrcNbr = @RefNbr AND
          SrcType = @SrcType AND
          CpnyID = @CpnyID

