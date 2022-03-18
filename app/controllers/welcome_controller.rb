class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby on Rails - Jackson Pires [Cookies]"
    #session[:curso] = "Curso de Ruby on Rails - Jackson Pires [Session]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
