Rails.application.routes.draw do

  resources :conversations, only: [:show, :create] do
    collection do
      get 'top'
      get 'new'
      get 'old'
      get 'hot'
    end

    member do
      post 'upvote'
      post 'downvote'
    end

    resources :responses, only: [:index, :create] do
      collection do
        get 'top'
      end

      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end

end
