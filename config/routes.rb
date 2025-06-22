Rails.application.routes.draw do
  root "welcome#index"
  get "api/songs", to: "api/songs#index"
end
