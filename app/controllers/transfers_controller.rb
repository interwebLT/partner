class TransfersController < SecureController
  
  before_action :except_admin
  
  def new
    @transfer = TransferRequest.new
  end
  
  def create
    transfer = TransferRequest.new transfer_request_params
    transfer.save token: current_user.token
#    @domain = Domain.find transfer_request_params[:domain], token: current_user.token
    redirect_to :controller => :domains, :action => :index
  end
  
  def update
    @domain = Domain.find params[:id], token: current_user.token
    transfer = TransferRequest.new domain: @domain.name
    transfer.update token: current_user.token
    redirect_to :controller => :domains, :action => :show, :id => @domain.id
  end
  
  def destroy
    @domain = Domain.find params[:id], token: current_user.token
    transfer = TransferRequest.new domain: @domain.name
    transfer.delete token: current_user.token
    
    redirect_to :controller => :domains, :action => :show, :id => @domain.id
  end
  
  private
  
  def transfer_request_params
    params[:transfer_request].permit :domain, :period, :auth_code
  end


end