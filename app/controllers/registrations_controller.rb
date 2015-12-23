class RegistrationsController < Devise::RegistrationsController

  def downgrade
      current_user.standard!
      current_user.wikis.update_all(private: false)
  end

  protected

  def after_sign_up_path_for(resource) #Devise method
    '/subscribers/new'
  end



end
