class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    resource.class.transaction do
      resource.save
      yield resource if block_given?
      if resource.persisted?
        @payment = Payment.new({ email: params["chef"]["email"],
                                 token: params[:payment]["token"], 
                                 chef_id: resource.id,
                                 card_number: params[:payment]["card_number"],
                                 card_cvv: params[:payment]["card_cvv"],
                                 card_expires_month: params[:payment]["card_expires_month"],
                                 card_expires_year: params[:payment]["card_expires_year"]})
        puts "="*100
        puts @payment.inspect
        flash[:error] = "Please check registration errors" unless @payment.valid?
        begin
          
          #@payment.obtain_token
          @payment.process_payment
          @payment.save
        rescue Exception => e
          flash[:error] = e.message
          resource.destroy
          
          puts 'Payment failed'
          render :new and return
        end
  
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |chef_params|
        chef_params.permit(:chefname, :email, :password, :password_confirmation, payment: [:card_number, :card_cvv, :card_expires_month, :card_expires_year])
      end
    end
end
