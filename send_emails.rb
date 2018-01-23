#test gmail 2
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp' #permet de faire des "p" propres !!!
require 'google_drive' #permet de faire le lien avec google drive
require 'gmail'
require_relative 'log' #permet d'éviter de mettre ses logs dans le fichier en les remplaçant par USERNAME et PASSWORD

########### on se log automatiquement sur le compte google utilisé et le googlesheet spécifié sur google drive #############

session = GoogleDrive::Session.from_config("config.json")
mierdasheet = session.spreadsheet_by_key("1iMKjhdL07m-h16faJgNNp0d_AmB8-OB4zTWLXqtIqKQ").worksheets[0] # ws est renommé en mierdasheet

puts mierdasheet[1,2] 


adressedelavictime = [] #tableau vide qui va recevoir les adresses mails des mairies

for i in 1..185 do #boucle qui va récupérer les lignes 1 à 185 du tableau
adressedelavictime << mierdasheet[i,2]
	
end

print adressedelavictime

#####

gmail = Gmail.connect(USERNAME,PASSWORD)

adressedelavictime.each do |email| #début de la boucle

	gmail.deliver do 
	to email #cette boucle va prendre "adressedelavictime" (donc les 185 entrées) et chaque contenu que l'on a nommé "email"
		subject "Une formation super cool pour tous"
		html_part do
		content_type 'text/html; charset=UTF-8' 
		body "<p>Bonjour, </p>
			<p>Je m'appelle Polo, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. </p> 
			<p>La formation s'appelle <em>The Hacking Project</em> (http://thehackingproject.org/). </p>
			<p>Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. </p> 
			<p>Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite. </p>
			<p>Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule dans votre commune, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. </p> 
			<p>Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec vous. </p> 
			<p> Polo, Moussaillon à The Hacking Project</p>"
		end
	end
end	#fin de la boucle
gmail.logout



########### fin du programme #############


