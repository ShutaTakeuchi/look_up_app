Rails.application.routes.draw do
  get "/" => "tweets#search"
end
