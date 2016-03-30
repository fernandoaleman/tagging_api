Rails.application.routes.draw do
  post "tag", to: "tags#create"
end
