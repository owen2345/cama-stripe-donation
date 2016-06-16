module Plugins::CamaStripeDonation::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def cama_stripe_donation_on_active(plugin)
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def cama_stripe_donation_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def cama_stripe_donation_on_upgrade(plugin)
  end

  def cama_stripe_before_front_load
    shortcode_add("stripe_donation", plugin_view('shortcode'), 'Generate stripe donation button, requires id')
  end

  def cama_stripe_donation_plugin_options(args)
    args[:links] << link_to(t('plugins.cama_stripe_donation.admin.link_settings', default: 'Settings'), admin_plugins_cama_stripe_donation_settings_path)
  end
end
