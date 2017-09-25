class DataPopulatorHelper
  def url_exist?(url_string)
    url = URI.parse(url_string)
    request = Net::HTTP.new(url.host, url.port)
    request.use_ssl = url.scheme if url.scheme == 'https'
    path = url.path if url.path.present?
    response = request.request_head(path || '/')
    if response.kind_of?(Net::HTTPRedirection)
      url_exist?(response['location']) # Go after any redirect and make sure you can access the redirected URL
    else
      response.code[0] != "4" # false if http code starts with 4 - error on your side.
    end
  rescue Errno::ENOENT
    false # false if can't find the server
  end
end