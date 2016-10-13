class TransfersController < SecureController
  
  before_action :except_admin
  
  def new
    @transfer = TransferRequest.new
  end
  
  def create
    transfer = TransferRequest.new transfer_request_params
    transfer.save token: current_user.token
#    @domain = Domain.find transfer_request_params[:domain], token: current_user.token
    flash[:notice] = "Transfer request successful."
    redirect_to :controller => :domains, :action => :index
  end
  
  def update
    transfer = TransferRequest.new id: params[:domain_id], domain: params[:id]
    transfer.update token: current_user.token
    flash[:notice] = "Transfer approval successful."
    redirect_to :controller => :domains, :action => :index
  end
  
  def destroy
    transfer = TransferRequest.new id: params[:domain_id], domain: params[:id]
    transfer.delete token: current_user.token
    flash[:notice] = "Transfer rejection successful."
    redirect_to :controller => :domains, :action => :show, :id => @domain.id
  end
  
  private
  
  def transfer_request_params
    params[:transfer_request].permit :domain, :period, :auth_code
  end

end