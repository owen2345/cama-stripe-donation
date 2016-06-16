Rails.application.config.to_prepare do
  CamaleonCms::Site.class_eval do
    has_many :stripe_donations, class_name: "Plugins::CamaStripeDonation::CamaStripeDonation"
  end
end