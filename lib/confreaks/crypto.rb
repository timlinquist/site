require 'digest/sha1'

module Confreaks #:nodoc:

  # Utilities for crypto and security related stuff.

  module Crypto
    # Always return the same hex digest for +thing+ and +extras+.

    def digest thing, *extras
      Digest::SHA1.hexdigest(([thing] + extras).join(" "))
    end

    # Always return a different hex salt, using +extras+ for added
    # flavor

    def salt *extras
      digest ActiveSupport::SecureRandom.hex(64), Time.now, *extras
    end

    module_function :digest, :salt
  end
end
