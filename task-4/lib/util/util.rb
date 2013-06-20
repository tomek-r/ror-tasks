require 'digest/sha1'

class Util
 def self.encrypt(string)
   Digest::SHA1.hexdigest(string)
 end
end
