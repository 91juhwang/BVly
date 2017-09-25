require 'mechanize'
require 'net/http'
require_relative './data_populator_helper'

data_populator_helper = DataPopulatorHelper.new

desc 'Access random links to acquire URLs and populate the database.'

task data_populator: :environment do
  agent = Mechanize.new
  page = agent.get('https://moz.com/top500/pages')
  page_links = page.links.flat_map(&:href)
  page_links.each_with_index do |link|
    begin
      Url.find_or_create_by(full_url: link) if data_populator_helper.url_exist?(link)
    rescue
      ap 'Invalid URL or corrupted!'
    end
  end
end
