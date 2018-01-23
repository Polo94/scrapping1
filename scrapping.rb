# On prendra l'exemple d'un mixer dans lequel on mettra tous les ingrédients à mixer, en guise de méthodologie.
# Cette idée de méthodo "mixer" follement efficace est l'oeuvre de @Ben CMJN... vous pouvez le flooder si elle vous plaît ^^

########### on appelle les gems ci-dessous #############

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp' 			#permet de faire des "p" propres !!!
require 'google_drive' #permet de faire le lien avec google drive

########### on se log automatiquement sur le compte google utilisé et le googlesheet spécifié #############

session = GoogleDrive::Session.from_config("config.json")
mierdasheet = session.spreadsheet_by_key("1iMKjhdL07m-h16faJgNNp0d_AmB8-OB4zTWLXqtIqKQ").worksheets[0] # ws est renommé en mierdasheet

########### on crée les 2 méthodes utilisées pour le fonctionnement du programme #############



def recupvilles # c'est le mixer (étape : 1)

pageweb = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html")) # ce sont les fruits (2)

listingvilles = [] # c'est le verre vide (3). c'est un tableau vide qui a vocation à être rempli

	pageweb.xpath('//a[@class="lientxt"]').each do |ville| # (4) c'est le filtre pour le jus récolté donc le texte (qui enlève les graines donc, les autres autres éléments)
	#.each do |ville| : on récolte chaque ville pour la laisser passer dans le verre
	
	listingvilles << ville.text #(5) on envoie le jus dans le verre

	end

return listingvilles # (6) c'est la sortie du jus du mixer ou la livraison du jus
#ce qui se passe à recupvilles, reste à recupvilles

end # fin de la méthode


def recupmails(nomdesmairies) #début de la méthode

listingmails = [] # c'est le verre vide (1). c'est un tableau vide qui a vocation à être rempli

	nomdesmairies.each do |commune| # on récupère chaque email dans nomsdesmairies

	newurl = commune.downcase.gsub(' ','-') #les urls sont rédigées en minuscule donc on met les noms de commune en minuscule et, on remplace les espaces par un tiret.

	pageweb = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/#{newurl}.html")) # ce sont les fruits (2)

	mail = pageweb.css('p:contains("@")').text.gsub(' ','') # on remplace les espaces par rien dans une adresse email dans le "p" qui contient un "@".

	listingmails << mail #on met les mails dans une variable listingmails

	end

return listingmails # livraison des emails pour pouvoir les utiliser à l'extérieur de la boucle.

end


#listingvilles : verre 1

#listingmails : verre 2

########### début du programme #############


recupvilles # bouton on : c'est l'action de présenter le contenu du verre (donc le jus) et qui permet d'utiliser c'e qu'il y a à l'intérieur de la première méthode, à l'extérieur
nomdesmairies = recupvilles # listingvilles ne peut exister que dans recupvilles, et n'en est qu'une fonction. Donc pour mettre le tableau listingvilles complété dans un autre verre, on appelle recupvilles et non listingvilles.
puts nomdesmairies


recupmails(nomdesmairies)
emaildesmairies = recupmails(nomdesmairies)
puts emaildesmairies

plateaudrinks = nomdesmairies.zip(emaildesmairies).to_h #on met les 2 verres obtenus (listingvilles et listingmails) sur un plateau, qu'on transforme en hash.


compteur = 0
plateaudrinks.each do |mairie,email|
	compteur += 1
	mierdasheet[compteur,1] = mairie #rangée compteur colonne 1, le programme écrira le premier nom de mairie qu'il trouve dans plateaudrinks
	mierdasheet[compteur,2] = email #rangée compteur colonne 2, le programme écrira le premier email qu'il trouve dans plateaudrinks
	#le programme continue en boucle jusqu'à la fin des paires "clé,valeur" (mairie,email) trouvées dans plateaudrinks
	end 
	


mierdasheet.save #on n'oublie surtout pas de sauvegarder le fichier googlesheet complété obtenu !!


########### fin du programe #############
