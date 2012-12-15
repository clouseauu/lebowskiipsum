class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def get_all_characters
      Character.all.map &:id
    end

    def get_minor_characters
      Character.all(conditions: { is_main: false } ).map &:id
    end

end
