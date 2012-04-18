IWantAQrCode::Application.routes.draw do
  match '(*text)' => 'home#index'
end
