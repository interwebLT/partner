class TransfersController < SecureController
  
  before_action :except_admin
  
  def new
    @transfer = TransferRequest.new
  end
  
  def create
    transfer = TransferRequest.new transfer_request_params
    if transfer.save token: current_user.token
#    @domain = Domain.find transfer_request_params[:domain], token: current_user.token
      flash[:notice] = "Transfer request successful."
    else
      flash[:alert] = "Transfer request failed."
    end
    redirect_to :controller => :domains, :action => :index
  end
  
  def update
    transfer = TransferRequest.new id: params[:domain_id], domain: params[:id]
    if transfer.update token: current_user.token
      flash[:notice] = "Transfer approval successful."
    else
      flash[:alert] = "Transfer approval failed."
    end
    redirect_to :controller => :domains, :action => :index
  end
  
  def destroy
    transfer = TransferRequest.new id: params[:domain_id], domain: params[:id]
    if transfer.delete token: current_user.token
      flash[:notice] = "Transfer rejection successful."
    else
      flash[:alert] = "Transfer rejection failed."
    end
    redirect_to :controller => :domains, :action => :show, :id => params[:domain_id]
  end
  
  private
  
  def transfer_request_params
    params[:transfer_request].permit :domain, :period, :auth_code
  end

end