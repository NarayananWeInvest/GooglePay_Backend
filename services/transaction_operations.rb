require_relative "scratch_card_operations.rb"

class TransactionOperations
	include ScratchCardGeneration
	attr_reader :ph_sender, :receiver, :amount

	def initialize(ph1, receiver, amount)
		@ph_sender = ph1
		@receiver = receiver
		@amount = amount
	end

	def call
		reward = transactionOperation
		return reward
	end

	private

		def transactionOperation

			if (ph_sender.length == 10 and ph_sender.scan(/\d/).length == 10) && (receiver.length == 10 and receiver.scan(/\d/).length == 10) 
				won = toPersonalReceiver(ph_sender,receiver)
				return won
			
			elsif (ph_sender.length == 10 and ph_sender.scan(/\d/).length == 10) && (receiver.casecmp?("bill payment"))
				won = billPayment(ph_sender)
				return won

			elsif (ph_sender.length == 10 and ph_sender.scan(/\d/).length == 10) && (receiver.casecmp?("recharge"))
				won = recharge(ph_sender)
				return won
			else
				return "transaction failed"
			end

		end

		def toPersonalReceiver(sender,receiver)
			user1 = User.where("phone" => sender).first
			user2 = User.where("phone" => receiver).first
			if user1.phone != user2.phone
				transaction = Transaction.new
				transaction.t_user1_id = user1.id
				transaction.t_user2_id = user2.id
				transaction.amount = amount
				transaction.save

 				senderAccount = BankAccount.where("user_id" => user1.id).first
 				receiverAccount = BankAccount.where("user_id" => user2.id).first
 				senderAmt = senderAccount.balance.to_i
 				receiverAmt = receiverAccount.balance.to_i
 				sufficientFund?(senderAmt,amount) ? senderAmt -= amount.to_i : (return "insufficient funds")
 				#senderAmt -= @amount.to_i
 				receiverAmt += amount.to_i

 				senderAccount.balance = senderAmt.to_s
 				receiverAccount.balance = receiverAmt.to_s

 				senderAccount.save
 				receiverAccount.save
 				user1.save
 				user2.save  

 				#transactionDetails = Array.new

 				return generateScratchCardPersonal(user1.id,user2.id,transaction.id)


 				#return "transaction successful"

 			else
 				return "transaction failed!!"
			end
		end

		def billPayment(sender)
			user1 = User.where("phone" => sender).first
			transaction = Transaction.new
			transaction.t_user1_id = user1.id
			transaction.t_user2_id = 1000
			transaction.amount = amount

			senderAccount = BankAccount.where("user_id" => user1.id).first
			senderAmt = senderAccount.balance.to_i
			sufficientFund?(senderAmt,amount) ? senderAmt -= amount.to_i : (return "insufficient funds")

			senderAccount.balance = senderAmt.to_s
			senderAccount.save
			user1.save

			return generateScratchCardBillPayment(user1.id,1000,transaction.id)

		end

		def recharge(sender)
			user1 = User.where("phone" => sender).first
			transaction = Transaction.new
			transaction.t_user1_id = user1.id
			transaction.t_user2_id = 1001
			transaction.amount = amount

			senderAccount = BankAccount.where("user_id" => user1.id).first
			senderAmt = senderAccount.balance.to_i
			sufficientFund?(senderAmt,amount) ? senderAmt -= amount.to_i : (return "insufficient funds")

			senderAccount.balance = senderAmt.to_s
			senderAccount.save
			user1.save

			return generateScratchCardRecharge(user1.id,1001,transaction.id)
		end

		def sufficientFund?(sender_amount,amount)
			remaining = sender_amount - amount.to_i
			if remaining >0 
				return true
			else
				return false
			end
		end
end