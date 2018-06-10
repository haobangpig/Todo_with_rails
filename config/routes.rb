Rails.application.routes.draw do

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
        patch :redo
      end
    end
  end

  root "todo_lists#index"
end
