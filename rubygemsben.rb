require 'rubygems'
require 'nokogiri'
require 'open-uri'

# On va créer un tableau à remplir
cities = []

# On va utiliser Nokogiri pour parcourir "annuaire-des-mairies.com"
def get_all_the_urls_of_val_doise_townhalls()
   page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
   cityTab = []

   page.xpath('//a[@class="lientxt"]').each do |name|
        cityTab << name.text
   end
       puts cityTab.length # On va afficher le nombre de villes (pages à scraper)
       get_the_email_of_a_townhal_from_its_webpage(cityTab) # on appelle la prochaine méthode
end

# Prochaine méthode :
def get_the_email_of_a_townhal_from_its_webpage(cities) 
    cities.each do |city| 
        url_cities = city.downcase.gsub(' ', '-') # On clean ce qu'on scrap, pour pouvoir l'insérer dans
        # Cette url, que Nokogiri va scrapper, une fois de plus
         page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{url_cities}.html"))
        puts page.css('p:contains("@")').text.gsub(' ','')
        #…et on récupère "@" des <p>  puisque un email est forcément avec un "@" ;)
    end 

end 
#------------------------ Fin des méthodes ------------

# GOGOGOGO !
get_all_the_urls_of_val_doise_townhalls()
#------------------------ Fin du programme ------------