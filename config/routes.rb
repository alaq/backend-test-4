Rails.application.routes.draw do
  resources :calls
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #post 'twilio/voice' => 'twilio#ivr_welcome'
  # Root of the app
  root 'calls#index'

  # webhook for your Twilio number
  match 'twilio/welcome' => 'twilio#ivr_welcome', via: [:get, :post], as: 'welcome'

  # callback for user entry
  match 'twilio/selection' => 'twilio#menu_selection', via: [:get, :post], as: 'menu'

  match 'twilio/recording_url' => 'twilio#recording_url', via: [:get, :post]

  match 'twilio/post_recording' => 'twilio#post_recording', via: [:get, :post]
  match 'twilio/recording_callback' => 'twilio#recording_callback', via: [:get, :post]
  match 'twilio/end_call' => 'twilio#end_call', via: [:get, :post]

end
