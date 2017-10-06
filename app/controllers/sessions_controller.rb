class SessionsController < ApplicationController
  def index
    # @bundle_time = Session.all
    @sessions ||= Session.all
  end
end
