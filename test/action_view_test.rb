require "test_helper"

class ActionViewTest < Minitest::Test
  def test_render_template
    template = ActionView::Template.new("<p>hello</p>", "test_render_template")
    context = ActionView::Base.new

    assert_equal "<p>hello</p>", template.render(context)
  end

  def test_render_with_vars
    template = ActionView::Template.new("<p><%= @var %></p>", "test_render_with_vars")
    context = ActionView::Base.new var: "var value"

    assert_equal "<p>var value</p>", template.render(context)
  end

  def test_render_with_yield
    template = ActionView::Template.new("<p><%= yield %></p>", "test_render_with_yield")
    context = ActionView::Base.new

    assert_equal "<p>yielded content</p>", template.render(context) { "yielded content" }
  end

  def test_render_with_helper
    template = ActionView::Template.new("<%= link_to 'title', '/url' %>", "test_render_with_helper")
    context = ActionView::Base.new

    assert_equal "<a href=\"/url\">title</a>", template.render(context)
  end

  def test_find_template
    file = "#{__dir__}/test_blog/app/views/layouts/application.html.erb"
    template1 = ActionView::Template.find(file)
    template2 = ActionView::Template.find(file)

    assert_same template1, template2
  end

  def test_view_assigns
    controller = TestController.new
    controller.index

    assert_equal({ "var" => "var value" }, controller.view_assigns)
  end

  def test_render
    request = Rack::MockRequest.new(Rails.application)
    response = request.get("/posts/show?id=1")
    
    assert_match "<h1>Standard Lorem Ipsum</h1>", response.body
    assert_match "<html>", response.body
  end

  def test_render_index
    request = Rack::MockRequest.new(Rails.application)
    response = request.get("/posts")

    assert_match "<h1>Test Blog</h1>", response.body
    assert_match "<html>", response.body
    assert_match '<a href="/posts/show?id=1">Standard Lorem Ipsum</a>', response.body
  end

  class TestController < ActionController::Base
    def index
      @var = "var value"
    end
  end
end