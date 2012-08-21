Hello::Application.routes.draw do |map|
  match '/:controller(/:action(/:id))'
end
