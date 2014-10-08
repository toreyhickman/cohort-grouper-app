class CohortsController < ApplicationController
  def index
    @cohorts = RetrieveActiveCohorts.call
  end
end
