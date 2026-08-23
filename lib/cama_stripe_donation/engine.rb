require 'stripe'
module CamaStripeDonation
  class Engine < ::Rails::Engine
    # Declare this plugin's shortcode name to Camaleon's boot-time shortcode registry so the CMS
    # save-time `content_shortcodes` gate can detect and gate it. Detection needs the name at boot
    # because the per-request shortcode list is empty at an admin save; the render-time handler stays
    # verbatim in main_helper (`shortcode_add`) -- authorship is gated, output is not filtered.
    # Guarded so the plugin still loads against camaleon_cms versions predating the registry.
    initializer 'cama_stripe_donation.register_shortcodes' do
      CamaleonCms::ShortcodeRegistry.register('stripe_donation') if defined?(CamaleonCms::ShortcodeRegistry)
    end
  end
end
