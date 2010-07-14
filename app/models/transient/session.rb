module Transient
  module Session
    def reset
      @user = self[:user_id] = nil
    end

    def user
      begin
        @user ||= User.find(self[:user_id]) if self[:user_id]
      rescue
        nil
      end
    end

    def user= user
      @user = user
      self[:user_id] = user && user.id
    end

    def anonymous?
      not user
    end

    def authenticated?
      not anonymous?
    end

    def bookmark
      self[:bookmark]
    end

    def bookmark= url
      self[:bookmark] = url
    end

    def pop_bookmark
      b=bookmark
      self.bookmark = nil
      b
    end
  end
end
