class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a stock symbol"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def add_to_portfolio
    stock = Stock.check_db(params[:ticker])
    
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end

    current_user.stocks << stock
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio" 
    redirect_to my_portfolio_path
  end

end
