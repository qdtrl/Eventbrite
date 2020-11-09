class UserMailer < ApplicationMailer
  default from: 'devqdt@yopmail.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://fierce-caverns-96407.herokuapp.com/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def new_event_subsciption_send(user, event)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 
    @event = event
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://fierce-caverns-96407.herokuapp.com/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Inscription événement !') 
  end
end
