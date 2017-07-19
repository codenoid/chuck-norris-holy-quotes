require "./chucknorriscr/*"
require "http/client"
require "json"
require "spinner"

spin = Spinner::Charset.values[30]
sp = Spin.new(0.1, spin)

module Chucknorriscr
  puts "[😌 ] What do you need honey?, you want random quote or what qoutes do you need ?"
  wdyw = gets
  if wdyw && wdyw.includes? "random quote" # or use match for more key
    sp.start
    HTTP::Client.get("https://api.chucknorris.io/jokes/random") do |response|
      response.status_code
      quote = response.body_io.gets
      if !quote.nil?
        data = JSON.parse quote
        puts "[😝 ] " + data["value"].to_s
        sp.stop
      end
    end
  elsif wdyw && !wdyw.includes? "random quote"
    url = "https://api.chucknorris.io/jokes/search?query=" + wdyw
    sp.start
    HTTP::Client.get(url) do |response|
      response.status_code
      quote = response.body_io.gets
      if !quote.nil?
        data = JSON.parse quote
        total = data["total"]
        data["result"].each do |holyquote|
          puts "[😝 ] " + holyquote["value"].to_s
        end
        sp.stop
      end
    end
  end
end
