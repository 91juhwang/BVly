require 'mechanize'
require 'net/http'
require 'timeout'
require_relative './data_populator_helper'

data_populator_helper = DataPopulatorHelper.new

desc 'Access random links to acquire URLs and populate the database.'

task data_populator: :environment do
  agent = Mechanize.new
  page = agent.get('https://moz.com/top500')
  page_links = page.links.flat_map(&:href)
  page_links.each_with_index do |link, i|
    begin
      Timeout::timeout(10) do
        begin
          Url.find_or_create_by(full_url: link) if data_populator_helper.url_exist?(link)
          ap "#{i}. #{link} -- was found or created."
        rescue
          ap "#{i}. #{link} was not added to the database"
        end
      end
    rescue Timeout::Error
      ap "#{i}. #{link} too too long to process, hence was not added."
    end
  end
end
