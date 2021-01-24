class PagesController < ApplicationController
  def index
  end

  def show
    render("pages/show")
  end
end
