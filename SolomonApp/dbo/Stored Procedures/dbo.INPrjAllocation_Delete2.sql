Create proc INPrjAllocation_Delete2 @RefNbr varchar(15), @SrcType varchar (3), @CpnyID varchar (10)  as
Delete From INPrjAllocation 
   where  SrcNbr = @RefNbr AND
          SrcType = @SrcType AND
          CpnyID = @CpnyID

