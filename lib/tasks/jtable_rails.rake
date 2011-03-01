namespace :jtable do
  desc 'Fetch latest jTable code'
  task :update => :environment do
    require 'net/http'
    require 'open-uri'
    url = "http://www.jtable.net/downloads/#{JTABLE_VERSION.gsub('.', '_')}"
    Net::HTTP.start(URI.parse(url).host) do |http|
      resp = http.get(URI.parse("#{url}/jTable.js").path)
      File.open(File.join(Rails.root, 'public', 'javascripts', 'jTable.js'), 'w+') do |file|
        file.write resp.body
      end
      
      resp = http.get(URI.parse("#{url}/jTable.css").path)
      File.open(File.join(Rails.root, 'public', 'stylesheets', 'jTable.css'), 'w+') do |file|
        file.write resp.body
      end
      
      resp = http.get(URI.parse("#{url}/jTable-icons.png").path)
      File.open(File.join(Rails.root, 'public', 'images', 'jTable-icons.png'), 'wb') do |file|
        file.write resp.body
      end
      
      resp = http.get(URI.parse("#{url}/jTable-processing_bg.png").path)
      File.open(File.join(Rails.root, 'public', 'images', 'jTable-processing_bg.png'), 'wb') do |file|
        file.write resp.body
      end
    end
  end
end