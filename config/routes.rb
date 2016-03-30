Rails.application.routes.draw do
  root to: "tags#stats"

  post "tag", to: "tags#create"
  get "tags/:entity_type/:entity_id", to: "tags#show"
  delete "tags/:entity_type/:entity_id", to: "tags#destroy"
  get "stats", to: "tags#stats"
end
