Rails.application.routes.draw do
  post "tag", to: "tags#create"
  get "tags/:entity_type/:entity_id", to: "tags#show"
  delete "tags/:entity_type/:entity_id", to: "tags#destroy"
end
