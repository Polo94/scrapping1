#scrapper cours de toutes les cryptomonnaies et ranger dans des hashes
#programme doit tourner en boucle, et scrappe toutes les heures

require 'rubygems'

require 'nokogiri'

require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage
#adressemail = http://annuaire-des-mairies.com/95/vaureal.html

doc = Nokogiri::HTML(open(http://annuaire-des-mairies.com/95/vaureal.html))
	city = [] #on crée un classeur vide

	dox.xpath('//a[@class="lientext"]').each do |name| #prendre chaque nom de ville
		city << name.text #mettre dans 
	end

		puts city.length
		get_the_email_of_a_townhal_from_its_webpage(city)

end

def get_all_the_urls_of_val_doise_townhalls
#adressemail = http://annuaire-des-mairies.com/val-d-oise.html
	cities.each do 
		url_cities = city.downcase.gsub(' ', '_')
			page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{url_cities}.html"))

			puts page.css('p:contains("@")').text.gsub(' ','')

	end
end

get_all_the_urls_of_val_doise_townhalls()

sleep(60)
