require_relative "branch"
require_relative "branchAsync"
require_relative "contacts"
require_relative "contactsAsync"
require_relative "rest"
require_relative "restAsync"
require_relative "soap"
require_relative "soapAsync"
require_relative "ticket"
require_relative "ticketAsync"
require_relative "users"
require_relative "usersAsync"

class Melipayamakapi
    def initialize(username, password)
        @username = username
        @password = password
    end
    def sms(method="rest", type="sync")
        if method=="soap"
            if type=="async"
                SoapAsync.new(@username,@password)
            else    
                Soap.new(@username,@password)
            end
        else
            if type=="async"
                RestAsync.new(@username,@password)
            else
                Rest.new(@username,@password)
            end
        end
    end
    def branch
        Branch.new(@username,@password)
    end
    def branchAsync
        BranchAsync.new(@username,@password)
    end
    def contacts
        Contacts.new(@username,@password)
    end
    def contactsAsync
        ContactsAsync.new(@username,@password)
    end
    def ticket
        Ticket.new(@username,@password)
    end
    def ticketAsync
        TicketAsync.new(@username,@password)
    end
    def users
        Users.new(@username,@password)
    end
    def usersAsync
        UsersAsync.new(@username,@password)
    end
end