Rails.application.routes.draw do

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'cama_stripe_donation' do
            post 'donate' => 'front#donate'
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'cama_stripe_donation' do
            get 'settings' => 'admin#settings'
            post 'settings' => 'admin#save_settings'
          end
        end
      end

      # main routes
      #scope 'cama_stripe_donation', module: 'plugins/cama_stripe_donation/', as: 'cama_stripe_donation' do
      #  Here my routes for main routes
      #end
    end
  end
