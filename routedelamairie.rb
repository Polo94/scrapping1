
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#On va créer un tableau à remplir:
cities = [] #premier tableau 

#On utilise Nokogiri pour parcourir "annuaire-des-mairies.com"
#Pour la construction du code, l'idée est de faire une méthode appeler une autre méthode.
#La seconde idée est de mettre un tableau dans un autre tableau.

#Première méthode :
def get_all_the_urls_of_val_doise_townhalls() #on choppe toutes les urls présentes sur la page
   	page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
   	cityTab = [] #second tableau 

   	page.xpath('//a[@class="lientxt"]').each do |name| 
   	#xpath est un langage qui permet de localiser des éléments ou des attributs précis dans un doc xml
	#le '//' c'est pour cibler ce qu'on va scrapper (ex: le paragraphe "p" ou "a" selon la façon dont on le nomme)
	#on utilise [@class="lientext"] pour prendre tous les élements "lientext" 

        cityTab << name.text # on va stocker dans le tableau "cityTab" chaque élément 
   end
       puts cityTab.length # la fonction .lenght va afficher le nombre de villes récupérées 
       get_the_email_of_a_townhal_from_its_webpage(cityTab) # ici, la première méthode "get_all_the_urls_of_val_doise_townhalls()" apelle la seconde méthode "get_the_email_of_a_townhal_from_its_webpage".
end

# Seconde méthode :
def get_the_email_of_a_townhal_from_its_webpage(cities) #on récupère l'email d'une des villes depuis la page qu'elle a généré grâce à une des urls dans le tableau de la première méthode.
    cities.each do |city| 
        url_cities = city.downcase.gsub(' ', '-') 
      
        page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{url_cities}.html"))
        
        puts page.css('p:contains("@")').text.gsub(' ','') #on récupère les éléments comportant un "@" donc les emails. Page.cass c'est pour récupérer des données dans un fichier css. Les ('') sont les délimiteurs utilisés.
 
        
    end 

end 

get_all_the_urls_of_val_doise_townhalls()
