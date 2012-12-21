class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def get_all_characters
      Character.all
    end

    def get_main_characters
      Character.find_all_by_is_main true
    end

    def get_minor_character_ids
      Character.all(conditions: { is_main: false } ).map &:id
    end

end
