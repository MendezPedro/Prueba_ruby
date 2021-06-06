require "uri"
require "net/http"
require 'json' #lo agregamos

def request (url, api_key)
    url = URI(url+api_key)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    hash = JSON.parse response.read_body # transformamos la información a un hash
    #la informacíon se genera en un string y se transforma a un hash
end


def buid_web_page(hash)
    html = "<html>\n\t<head>\n\t\t<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css' integrity='sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l' crossorigin='anonymous'>\n\t</head>\n\t<body style='background-color:999999; padding:25px;'>\n\t\t<ul class='container row'>"


    hash['photos'].each do |image|
        url = image['img_src']
        html += "\n\t\t\t<li class='img-thumbnail mx-3 my-3' style='max-height: 130px; padding:5px; max-width: 190px;'><img style='max-height: 120px; max-width: 180px;' src=#{url}></li>"
    end

    html += "\n\t\t</ul>\n\t</body>\n</html>" 

    File.write('index.html', html)

end

url1 = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10"
api_key1 = "&api_key=fw3RZEza3NH347GzATnd8bEEmDKmC4zc8xbQz9Dj"


hash = request(url1,api_key1)



#usar map para recorer el arreglo y obtener un hash solo con las fotos
buid_web_page(hash)