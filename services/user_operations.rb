
class UserOperations
	attr_reader :name, :phone

    def initialize(nameU, phone)
		@name = nameU
		@phone = phone 
    end

	def call
        flag = insertOperation
        return flag
	end

	private

		def insertOperation
			if phone.length != 10 or phone.scan(/\d/).length != 10
				return "error!! invalid phone number"
			else
				clear
				user = User.new
				user.name = @name
				user.phone = @phone
				#@user.phone = @phone if is_phonePresent?(@phone)
				user.save
				return "inserted bank details successfully"
			end
		end

        def is_phonePresent?(phone)
        	size= User.where("phone" => phone).count
        	if size > 0
        		return false
        	else
        		return true
        	end
        end

        def clear
        	clear = User.new
        	size = User.where("phone" => clear.phone).count
        	for i in 0..size-1
        		User.where("phone" => clear.phone).first.delete
        	end
        end
end
