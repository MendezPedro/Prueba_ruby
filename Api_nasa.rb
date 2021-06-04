require "uri"
require "net/http"
require 'json' #lo agregamos

def request (url, api_key)
    url = URI(url+api_key)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    hash = JSON.parse response.read_body # transformamos la información a un arreglo

end


def buid_web_page(hash)
    hash
end

url1 = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10"
api_key1 = "&api_key=fw3RZEza3NH347GzATnd8bEEmDKmC4zc8xbQz9Dj"


hash = request(url1,api_key1)
puts hash['photos']
#puts buid_web_page(hash)

