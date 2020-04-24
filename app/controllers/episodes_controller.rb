require 'open-uri'

class EpisodesController < ApplicationController
  before_action :require_login!
  before_action :require_subscription!
  layout 'dashboard'

  def index
    @episodes = []
    url = 'https://feeds.transistor.fm/avilla-theory'
    open(url) do |rss|
      @episodes = RSS::Parser.parse(rss, false).items
    end
  end
end
