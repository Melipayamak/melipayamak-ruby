require_relative "branch"
require_relative "contacts"
require_relative "rest"
require_relative "soap"
require_relative "ticket"
require_relative "users"

class Melipayamakapi
    def initialize(username, password)
        @username = username
        @password = password
    end
    def sms(type="rest")
        if type=="rest"
            Rest.new(@username,@password)
        else
            Soap.new(@username,@password)
        end
    end
    def branch
        Branch.new(@username,@password)
    end
    def contacts
        Contacts.new(@username,@password)
    end
    def ticket
        Ticket.new(@username,@password)
    end
    def users
        Users.new(@username,@password)
    end
end