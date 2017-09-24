class UserUrl < ActiveRecord::Base
  belongs_to :user
  belongs_to :url

  def self.url_to_external(text)
    /\Ahttp(s)?:\/\//.match(text) ? text : text.gsub(/\A(http(s)?:\/\/)?(www\.)?(.*)/,"http\\2://www.\\4")
  end

  def self.update_access_count(found_url)
    found_url.access_count + 1
  end
end