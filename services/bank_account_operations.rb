class BankAccountOperations
   	attr_reader :id, :acc_no, :ifsc, :balance

    def initialize(id, accNo, ifsc, amount)
 		@id = id
 		@acc_no = accNo
 		@ifsc = ifsc
 		@balance = amount
    end

    def call
    	flag = insertOperation
    	return flag
    end

    private

    	def insertOperation
    		if !acc_no.scan(/\D/).empty? or acc_no.scan(/\d/).length != 11
				return "error!! invalid account number"

			elsif !acc_no.scan(/\D/).empty?
				return "error!! amount should be in numbers"
				
			else
				ba = BankAccount.new
				ba.acc_no = acc_no
				ba.ifsc = ifsc
				ba.balance = balance
				ba.user_id = id
				ba.save
				return "inserted bank account details successfully"
			end
		end

end