Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete 'shelters/:id', to: 'shelters#destroy'

  get '/shelters/:id/pets', to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'

  get '/shelters/:id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:id/reviews', to: 'shelter_reviews#create'
  get '/shelters/:id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:id/reviews/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:id/reviews/:review_id', to: 'shelter_reviews#delete'
  get '/shelters/:id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:id/reviews', to: 'shelter_reviews#create'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id/pending', to: 'pets#pending'
  patch '/pets/:id/adoptable', to: 'pets#adoptable'
  patch '/pets/:id', to: 'pets#update'
  post '/shelters/:id/pets', to: 'pets#create'
  delete '/pets/:id', to: 'pets#destroy'

  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  get '/favorites', to: 'favorites#index'
  delete '/favorites', to: 'favorites#delete_all'

  get '/applications/new', to: 'application_pets#new'
  post '/applications', to: 'application_pets#create'
  get '/pets/:pet_id/applications', to: 'pets#applications'
  post '/pets/:pet_id/applications/:application_id', to: 'application_pets#approve'
  patch '/pets/applications/:application_id', to: 'application_pets#approve_pets'
  delete '/pets/:pet_id/applications/:application_id', to: 'application_pets#delete'

  get '/applications/:id', to: 'application_pets#show'
end
