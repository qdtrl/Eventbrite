class ChargesController < ApplicationController
  def new
  end
  
  def create
    p "#"*23
    p current_user.id
    p "#"*23
    @event = set_event
    if @event.attendances.include? current_user
      flash[:error] = "Vous participez déjà à l'évènement !"
      redirect_to @event
    end

    # Amount in cents
    @amount = @event.price
  
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Payement",
      currency: 'eur',
    })

    @event.attendances << current_user
    flash[:success] = "Vous participez à l'évènement !"
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event 
  end 

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = User.find()
  end
end
