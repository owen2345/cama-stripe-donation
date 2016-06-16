class Plugins::CamaStripeDonation::AdminController < CamaleonCms::Apps::PluginsAdminController
  include Plugins::CamaStripeDonation::MainHelper
  def settings
    # actions for admin panel
  end

  def save_settings
    @plugin.set_options(params[:option])
    flash[:notice] = t('.settings_saved', default: 'Settings Saved')
    redirect_to action: :settings
  end
end
