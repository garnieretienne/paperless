module ApplicationHelper

  def render_module(module_name, locals = {})
    render partial: "modules/#{module_name}", locals: locals
  end
end
