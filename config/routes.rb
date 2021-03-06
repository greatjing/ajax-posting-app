Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/jquery-1" => "pages#jquery_1"
  get "/jquery-2" => "pages#jquery_2"
  get "/jquery-3" => "pages#jquery_3"
  get "/jquery-4" => "pages#jquery_4"
  get "/jquery-5" => "pages#jquery_5"

  resources :posts do
    member do
      post "like" => "posts#like"
      # post "unlike" => "posts#unlike"
      #post :like
      post :unlike
      post :collect
      post :uncollect
      # 标记
      post :toggle_flag
      # 打分
      post :rate
    end
  end

  root "posts#index"
end
