require 'net/http'
require 'json'
require 'base64'

uri = URI('http://api.perka.com/1/communication/job/apply')
req = Net::HTTP::Post.new(uri)
req.content_type = 'application/json'

resume = File.binread("one_page_resume.pdf")
coded_resume = Base64.encode64(resume)
req.body = JSON.generate({
  first_name: "Gabe",
  last_name: "Finch",
  email: "gabefinch@gmail.com",
  position_id: "JS",
  explanation: "Ruby script, Base64 from web based converter.",
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

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
 http.request(req)
end

puts res.code       # => '200'
puts res.message    # => 'OK'
puts res.class.name # => 'HTTPOK'
