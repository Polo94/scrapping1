require 'rubygems'

require 'nokogiri'

require 'open-uri'

#récupérer : nom de l'incubateur, code postal, site web

def get_the_email_of_a_townhal_from_its_webpage
#adressemail = http://annuaire-des-mairies.com/95/vaureal.html

doc = Nokogiri::HTML(open(http://annuaire des gentils incubateurs)) # on met le contenu de l'url dans un objet de Nokogiri
	incubateurs = [] #on crée un classeur vide pour les différentes monnaies à scrapper

	dox.xpath('//a[@class="lientext"]').each do |name| #prendre chaque nom de ville
		incubateurs << name.text # on met le nom de chaque incubateur dans "incubateur" 
	end

		puts incubateurs.length
		get_the_email_of_a_townhal_from_its_webpage(coin)

end


