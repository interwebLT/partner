class DragonPayController < SecureController
  
  def setup_payment
    if params[:amount].blank? or not is_number? params[:amount]
      flash[:alert] = "Please choose from the following replenish amounts."
      redirect_to checkout_index_path and return
    end
    
    amount = params[:amount].to_f.money
    
  end
  
end