module ActionController
  class Base < Metal
    include Callbacks
    include Redirecting
    include ImplicitRender
    include ActionView::Rendering
  end
end