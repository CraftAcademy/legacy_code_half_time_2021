# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :analyses, only: %i[create index]
  end
end
