module waterDispenser(input logic sensor, clock, resetN,
					 output logic dispense);
enum logic [2:0] {
		ZERO 		   = 3'b000, 
		TWENTYFIVE 	   = 3'b001,
		FIFTY      	   = 3'b010,
		SEVENTYFIVE	   = 3'b011,
		DOLLAR         = 3'b100,
		DOLLAR25       = 3'b101,
		DOLLAR50       = 3'b110,
		DOLLAR75       = 3'b111
		 } 
				   PresentState, NextState;

always_ff @(posedge clock or negedge resetN)  
	if(~resetN) PresentState <= ZERO;
    else PresentState <= NextState;	

always_comb begin 
	case (PresentState)
		ZERO: if(sensor) NextState = TWENTYFIVE;
			  else 		 NextState = ZERO;

		TWENTYFIVE: if(sensor) NextState = FIFTY;
			  else 		 NextState = TWENTYFIVE;

		FIFTY: if(sensor) NextState = SEVENTYFIVE;
			  else 		 NextState = FIFTY;

		SEVENTYFIVE: if(sensor) NextState = DOLLAR;
			  else 		 NextState = SEVENTYFIVE;

		DOLLAR: if(sensor) NextState = DOLLAR25;
			  else 		 NextState = DOLLAR;

		DOLLAR25: if(sensor) NextState = DOLLAR50;
			  else 		 NextState = DOLLAR25;

		DOLLAR50: if(sensor) NextState = DOLLAR75;
			  else 		 NextState = DOLLAR50;

		DOLLAR75: if(sensor) NextState = TWENTYFIVE;
				  else 		 NextState = ZERO;

		default : NextState = ZERO;
	endcase
end

always_comb begin
	case (PresentState)
		ZERO 	      : dispense = 0;
		TWENTYFIVE    : dispense = 0;  
		FIFTY         : dispense = 0;  
		SEVENTYFIVE   : dispense = 0;  
		DOLLAR        : dispense = 0;  
		DOLLAR25      : dispense = 0;  
		DOLLAR50      : dispense = 0;  
		DOLLAR75      : dispense = 1;
		default 	  : dispense = 0;
	endcase
end

endmodule : waterDispenser


