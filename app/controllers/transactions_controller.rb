class TransactionsController < ApplicationController
  # GET /transactions or /transactions.json
  def index
    # @article = Article.find(params[:article_id])
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @article = Article.find(params[:article_id])
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @article = Article.find(params[:article_id])
    @transaction = Transaction.new(transaction_params)

    @transaction.user = current_user
    @transaction.article = Article.find(params[:article_id])
    @transaction.amount = @transaction.article.price

    @author = Article.find(params[:article_id]).user


    respond_to do |format|
      # the user is the author
      if @author == current_user
        format.html { redirect_to article_url(@article), notice: "Don't need to Pay. You are the author." }
        format.json { render :show, status: :created, location: @article }
      # the article is free
      elsif @transaction.amount == 0
        format.html { redirect_to article_url(@article), notice: "Don't need to Pay. It is free." }
        format.json { render :show, status: :created, location: @article }
      # the reader has paid for it
      elsif Transaction.exists?(user: current_user, article: @transaction.article)
        format.html { redirect_to article_url(@article), notice: "You don't need to pay more than once." }
        format.json { render :show, status: :created, location: @article }
      # the reader has enough coins
      elsif current_user.balance >= @transaction.amount
        ActiveRecord::Base.transaction do
          current_user.update(balance: current_user.balance - @transaction.amount)
          @author.update(balance: @author.balance + @transaction.amount)
          # Transaction.create(sender: @sender, receiver: @receiver, amount: @amount)
          if @transaction.save
            format.html { redirect_to article_url(@article), notice: "Transaction was successfully created." }
            format.json { render :show, status: :created, location: @article }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
            raise ActiveRecord::Rollback
          end
        end
      else
        format.html { redirect_to root_path, notice: "Oh no. You cannot afford it." }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :article_id, :amount)
    end
end
