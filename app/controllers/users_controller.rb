class UsersController < ApplicationController

  def downgrade
    current_user.standard!
    current_user.save
    flash[:alert] = "Note: all private wikis you've created will become public upon downgrade"
    @wikis.user.private? == @wiki.public!
  end

end
