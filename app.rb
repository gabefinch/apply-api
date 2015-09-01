require 'net/http'
require 'json'
require 'base64'

uri = URI.parse('https://api.perka.com/1/communication/job/apply')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

json_headers = {"Content-Type" => "application/json",
                "Accept" => "application/json"}

resume = File.binread("one_page_resume.pdf")
coded_resume = Base64.encode64(resume)
body = JSON.generate({
  first_name: "Gabe",
  last_name: "Finch",
  email: "gabefinch@gmail.com",
  position_id: "JS",
  explanation: "Ruby script",
  projects: [
      "https://github.com/gabefinch/answer-me",
      "http://vast-shore-5799.herokuapp.com/",
      "https://github.com/gabefinch/flash-cards",
      "http://gabefinch.github.io/flash-cards/",
      "https://github.com/gabefinch/humble-pie-pizza",
      "http://gabefinch.github.io/humble-pie-pizza/"
  ],
  source: "PDX_TechCrawl_2015",
  resume: coded_resume
})

response = http.post(uri.path, body, json_headers)


puts response.code       # => '200'
puts response.message    # => 'OK'
puts response.class.name # => 'HTTPOK'
