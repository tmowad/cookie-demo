class HeaderLogger
  def initialize(app)
    @app = app
    @f = File.open("/tmp/headers", "w")
  end
  def call(env)
    @f.puts("\n\nREQUEST HEADERS >>>>>>>>>\n" +
      format_headers(env) +
      "===============\n")
    status,headers,response = @app.call(env)
    response_headers = (headers.map { |k,v| "#{k}: #{v}" }.join("\n"))
    @f.puts("\n\nRESPONSE HEADERS <<<<<<<<<<<\n#{response_headers}\n===========\n")
    @f.flush
    [status,headers,response]
  end

  private

  def format_headers(hash)
    hash.map do |h,v|
      "#{h.downcase.gsub(/^http_/,'').gsub(/_/,'-').capitalize}: #{v}\n" if
        h =~ /^HTTP/
    end.compact.join ''
  end

end
