require 'nokogiri'
require 'httparty'
require 'byebug'


def scraper
    url = "https://www.amazon.pl/gp/bestsellers/books/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    objects = Array.new
    items = parsed_page.css('li.zg-item-immersion')
    items.each do |item|
        dict = {
            title: item.css('a.a-link-normal')[0].css('div')[1].text.strip,
            price: item.css('span.p13n-sc-price').text,
        }
        objects << dict
    end
    objects.each do |obj| 
        puts obj
    end   
end

scraper