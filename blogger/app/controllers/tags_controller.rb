class TagsController < ApplicationController
  include ArticlesHelper
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
