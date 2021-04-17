class DemoController < ApplicationController
  layout 'application'

  def index
    render('index')
  end

  def hello
    @array = [1, 3, 5, 6]
    @id = params[:id]
    @page = params['page']
    render('hello')
  end

  def other_hello
    redirect_to(:action => 'hello')
  end

  def escape_output
  end
end
