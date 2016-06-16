class Plugins::CamaStripeDonation::FrontController < CamaleonCms::Apps::PluginsFrontController
  include Plugins::CamaStripeDonation::MainHelper
  ENCODE_PARAMS = ['price', 'file']
  def donate
    self.class::ENCODE_PARAMS.each{|i| params[i.to_sym] = Base64.decode64(params[i.to_sym]) }
    Stripe.api_key = @plugin.get_option('secret_key')
    amount = (params[:price].to_d * 100).to_i
    currency = params[:currency]
    customer = Stripe::Customer.create(
        :email => params[:stripe][:email],
        :source  => params[:stripe][:id]
    )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => amount,
        :description => params['description'],
        :currency    => currency
    )
    hooks_run('', {amount: amount, currency: currency, file: params[:file]})
    flash[:notice] = @plugin.get_option('thanks_message', "Thanks for donate %{amount} %{currency}.").translate.gsub('%{amount}', params[:price]).gsub('%{currency}', currency.upcase)
    if params[:file].present?
      send_file CamaleonCmsLocalUploader::private_file_path(params[:file], current_site)
    else
      redirect_to :back
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end
end
