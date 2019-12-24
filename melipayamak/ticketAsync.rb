require 'savon'

class TicketAsync
    def initialize(username, password)
        @username = username
        @password = password
        @client = Savon.client(wsdl: "http://api.payamak-panel.com/post/Tickets.asmx?wsdl")
    end
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    def execute(method,data)
        response = nil
        t = Thread.new{response = @client.call(method, message:data.merge(get_data))}
        t.join
        response.body
    end
    def add(title, content, aws=true)
        execute(:add_ticket,{
            :title => title,
            :content => content,
            :alertWithSms => alertWithSms
        })
    end
    def get_received(ticketOwner, ticketType, keyword)
        execute(:get_received_tickets,{
            :ticketOwner => ticketOwner,
            :ticketType => ticketType,
            :keyword => keyword
        })
    end
    def get_received_count(ticketType)
        execute(:get_received_tickets_count,{
            :ticketType => ticketType
        })
    end
    def get_sent(ticketOwner, ticketType, keyword)
        execute(:get_sent_tickets,{
            :ticketOwner => ticketOwner,
            :ticketType => ticketType,
            :keyword => keyword
        })
    end
    def get_sent_count(ticketType)
        execute(:get_sent_tickets_count,{
            :ticketType => ticketType
        })
    end
    def response(ticketId, type, content, alertWithSms=true)
        execute(:response_ticket,{
            :ticketId => ticketId,
            :content => content,
            :alertWithSms => alertWithSms,
            :type => type
        })
    end
end