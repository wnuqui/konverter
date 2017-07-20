Rails.application.routes.draw do
  post '/conversions', to: 'conversions#create'
end
