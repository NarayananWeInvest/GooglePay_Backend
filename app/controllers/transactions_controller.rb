require_dependency "services/transaction_operations.rb"

class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    # @transaction = Transaction.new(transaction_params)

    # if @transaction.save
    #   render json: @transaction, status: :created, location: @transaction
    # else
    #   render json: @transaction.errors, status: :unprocessable_entity
    # end
    # puts "save"
    @result = TransactionOperations.new(params[:phone_sender],params[:receiver], params[:amount]).call

    print @result
    @senderCard = Array.new
    @receiverCard = Array.new

    @senderCard[0] = @result[0]
    @senderCard[1] = @result[2]
    @senderCard[2] = @result[4] 

    @receiverCard[0] = @result[1]
    @receiverCard[1] = @result[3]
    @receiverCard[2] = @result[5]
    render :json => {"sender" => @senderCard, "receiver" => @receiverCard}, location: transactions_url(@result)
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:t_user1_id, :t_user2_id, :amount)
    end
end
