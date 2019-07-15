class CanvasObject < Forgery

  def self.push_csv_to_canvas(opts={})
    if(opts.nil? || opts[:host].nil? || opts[:token].nil?)
      raise 'Please provide options hash with both :host and :token'
    end
    if(!File.file?(opts[:file]))
      raise 'Please gen_file before trying to push to canvas'
    end
    uri = URI.parse("https://#{opts[:host]}/api/v1/accounts/self/sis_imports.json?import_type=instructure_csv")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "text/csv"
    request["Authorization"] = "Bearer #{opts[:token]}"
    request.body = ""
    request.body << File.read(opts[:file])

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
