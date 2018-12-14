module ScratchCardGeneration

	def generateScratchCardPersonal(sender, receiver, t_id)
		rewardsWon = Array.new
		yearReward = yearlyCard("Sender","Receiver",sender,receiver,t_id)
 		monthReward = monthlyCard("Sender","Receiver",sender,receiver,t_id)
 		dailyReward = dailyCard("Sender","Receiver",sender,receiver,t_id)

 		rewardsWon = yearReward + monthReward + dailyReward

 		card1 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[0], "trans_id_id" => t_id)
   		card1.save
   		card2 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[2], "trans_id_id" => t_id)
   		card2.save
   		card3 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[4], "trans_id_id" => t_id)
   		card3.save
   		card4 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[1], "trans_id_id" => t_id)
    	card4.save
	    card5 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[3], "trans_id_id" => t_id)
	    card5.save
    	card6 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[5], "trans_id_id" => t_id)
    	card6.save
 		#updateTable(sender,receiver,t_id,rewardsWon)   

 		return rewardsWon
	end

	def generateScratchCardBillPayment(sender, receiver, t_id)
		rewardsWon = Array.new
		yearReward = yearlyCard("Sender","BillPayment",sender,receiver,t_id)
 		monthReward = monthlyCard("Sender","BillPayment",sender,receiver,t_id)
 		dailyReward = dailyCard("Sender","BillPayment",sender,receiver,t_id)

 		rewardsWon = yearReward + monthReward + dailyReward
 		card1 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[0], "trans_id_id" => t_id)
   		card1.save
   		card2 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[2], "trans_id_id" => t_id)
   		card2.save
   		card3 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[4], "trans_id_id" => t_id)
   		card3.save
   		card4 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[1], "trans_id_id" => t_id)
    	card4.save
	    card5 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[3], "trans_id_id" => t_id)
	    card5.save
    	card6 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[5], "trans_id_id" => t_id)
    	card6.save
 		#updateTable(sender,receiver,t_id,rewardsWon) 

 		return rewardsWon
	end

	def generateScratchCardRecharge(sender, receiver, t_id)
		rewardsWon = Array.new
		yearReward = yearlyCard("Sender","Recharge",sender,receiver,t_id)
 		monthReward = monthlyCard("Sender","Recharge",sender,receiver,t_id)
 		dailyReward = dailyCard("Sender","Recharge",sender,receiver,t_id)

 		rewardsWon = yearReward + monthReward + dailyReward

 		card1 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[0], "trans_id_id" => t_id)
   		card1.save
   		card2 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[2], "trans_id_id" => t_id)
   		card2.save
   		card3 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[4], "trans_id_id" => t_id)
   		card3.save
   		card4 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[1], "trans_id_id" => t_id)
    	card4.save
	    card5 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[3], "trans_id_id" => t_id)
	    card5.save
    	card6 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[5], "trans_id_id" => t_id)
    	card6.save

 		#updateTable(sender,receiver,t_id,rewardsWon) 

 		return rewardsWon
	end

	private 

		def dailyCard(sender_type,receiver_type,sender,receiver,t_id)
			reward = Array.new
			previousDay = ((Time.now - ((5*3600)+(30*60))) - (24*60*60))
			dailySender = Rule.where("type_user" => sender_type).where("period" => "daily").first
			dailyReceiver = Rule.where("type_user" => receiver_type).where("period" => "daily").first

			if isEligibleSender?(sender,dailySender.limit,dailyReceiver.min_range,dailyReceiver.max_range,previousDay,t_id)
				reward[0] = rand(dailySender.scratch_card_min..dailySender.scratch_card_max).to_i
			else
				reward[0] = "no scratch card"
			end

			if isEligibleReceiver?(receiver,dailyReceiver.limit,dailyReceiver.min_range,dailyReceiver.max_range,previousDay,t_id)
				reward[1] = rand(dailyReceiver.scratch_card_min..dailyReceiver.scratch_card_max).to_i
			else
				reward[1] = "no scratch card"
			end

			dailySender.save
			dailyReceiver.save

			return reward
		end

		def monthlyCard(sender_type,receiver_type,sender,receiver,t_id)
			reward = Array.new
			previousMonth = ((Time.now - ((5*3600)+(30*60))) - (31*60*60))
			monthlySender = Rule.where("type_user" => sender_type).where("period" => "monthly").first
			monthlyReceiver = Rule.where("type_user" => receiver_type).where("period" => "monthly").first

			if isEligibleSender?(sender,monthlySender.limit,monthlyReceiver.min_range,monthlyReceiver.max_range,previousMonth,t_id)
				reward[0] = rand(monthlySender.scratch_card_min..monthlySender.scratch_card_max).to_i
			else
				reward[0] = "no scratch card"
			end

			if isEligibleReceiver?(receiver,monthlyReceiver.limit,monthlyReceiver.min_range,monthlyReceiver.max_range,previousMonth,t_id)
				reward[1] = rand(monthlyReceiver.scratch_card_min..monthlyReceiver.scratch_card_max).to_i
			else
				reward[1] = "no scratch card"
			end

			monthlySender.save
			monthlyReceiver.save

			return reward
		end

		def yearlyCard(sender_type,receiver_type,sender,receiver,t_id)

			reward = Array.new
			previousYear = ((Time.now - ((5*3600)+(30*60))) - (365*24*60*60))
			yearlySender = Rule.where("type_user" => sender_type).where("period" => "yearly").first
			yearlyReceiver = Rule.where("type_user" => receiver_type).where("period" => "yearly").first

			if isEligibleSender?(sender,yearlySender.limit,yearlyReceiver.min_range,yearlyReceiver.max_range,previousYear,t_id)
				reward[0] = rand(yearlySender.scratch_card_min..yearlySender.scratch_card_max).to_i
			else
				reward[0] = "no scratch card"
			end

			if isEligibleReceiver?(receiver,yearlyReceiver.limit,yearlyReceiver.min_range,yearlyReceiver.max_range,previousYear,t_id)
				reward[1] = rand(yearlyReceiver.scratch_card_min..yearlyReceiver.scratch_card_max).to_i
			else
				reward[1] = "no scratch card"
			end

			yearlySender.save
			yearlyReceiver.save

			return reward
		end

		def isEligibleSender?(sender,limit,amount_min,amount_max,timeStamp,id)
			senderAsSenderT = Transaction.where("t_user1_id" => sender).where("created_at >= ?", timeStamp).all
 			senderAsReceiverT = Transaction.where("t_user1_id" => sender).where("created_at >= ?", timeStamp).all

 			value = Transaction.find(id)

 			senderTransaction = senderAsSenderT + senderAsReceiverT

 			value.save

 			if (limit <= senderTransaction.length) && ((value.amount.to_i < amount_max) && (value.amount.to_i > amount_min)) 
 				return true
 			else
 				return false
 			end
 			
		end
		
		def isEligibleReceiver?(receiver, limit, amount_min,amount_max,timeStamp,id)
			receiverAsSenderT = Transaction.where("t_user1_id" => receiver).where("created_at >= ?", timeStamp).all
 			receiverAsReceiverT = Transaction.where("t_user1_id" => receiver).where("created_at >= ?", timeStamp).all

 			value = Transaction.find(id)

 			receiverTransaction = receiverAsSenderT + receiverAsSenderT

 			value.save

 			if (limit <= receiverTransaction.length) && ((value.amount.to_i < amount_max) && (value.amount.to_i > amount_min)) 
 				return true
 			else
 				return false
 			end


		end

		def hasCard?(value)
			if value.scan(/\d+/)[0][0] != "" and value.scan(/\d+/)[0][0].to_i > 0 
				return true
			else
				return false
			end
		end

		def updateTable(sender, receiver, rewardsWon, t_id)
			(0..5).step(2) do |i|
			
   				# card1 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[0], "trans_id_id" => t_id)
   				# card1.save
   				# card2 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[2], "trans_id_id" => t_id)
   				# card2.save
   				# card3 = ScratchCard.create("user_id" => sender, "amount_won" => rewardsWon[4], "trans_id_id" => t_id)
   				# card3.save
   				card1 = ScratchCard.new
   				card1.user_id = sender
   				card1.amount_won = rewardsWon[i].to_s
   				card1.trans_id_id = t_id
   				card1.save
			end

 			(1..5).step(2) do |j|
    			# card4 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[1], "trans_id_id" => t_id)
    			# card4.save
	    		# card5 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[3], "trans_id_id" => t_id)
	    		# card5.save
    			# card6 = ScratchCard.create("user_id" => receiver, "amount_won" => rewardsWon[5], "trans_id_id" => t_id)
    			# card6.save
    			card2 = ScratchCard.new
   				card2.user_id = receiver
   				card2.amount_won = rewardsWon[j].to_s
   				card2.trans_id_id = t_id
   				card2.save
			end
		end
end