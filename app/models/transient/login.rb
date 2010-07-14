module Transient
  class Login
    attr_accessor :username, :password

    def initialize params
      unless params.blank?
        @username, @password = params.values_at :username, :password
      end
    end
  end
end
