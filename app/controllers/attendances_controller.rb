class AttendancesController < ApplicationController
  def new
  end
  
  def create
    print params
    @event = set_event
    if @event.attendances.include? current_user
      flash[:error] = "Vous participez déjà à l'évènement !"
      redirect_to @event
      return
    end

    # Amount in cents
    @amount = @event.price
  
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount * 100,
      description: "Payement",
      currency: 'eur',
    })

    Attendance.create(
      user_id: current_user.id,
      event_id: @event.id,
      stripe_customer_id: charge.customer
    )
    flash[:success] = "Vous participez à l'évènement !"
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event 
  end 

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user
    @user = User.find()
  end
end
