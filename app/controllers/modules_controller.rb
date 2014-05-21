class ModulesController < ApplicationController
  layout :false

  ALLOWED_MODULES = [:progress_bar]

  # Allow to retrieve a module HTML code from an ajax call
  def render_module
    @module_name = params[:module_name]
    if !is_module_allowed? @module_name
      return render nothing: true, status: 404
    end
    @locals = params[:locals]
  end

  private

  # Test if a module is allowed to be delivered using AJAX
  def is_module_allowed?(module_name)
    ALLOWED_MODULES.include? module_name.to_sym
  end
end