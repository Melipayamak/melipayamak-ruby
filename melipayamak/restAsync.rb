require "http"

class RestAsync
    @@path = "https://rest.payamak-panel.com/api/SendSMS/%s"
    
    def initialize(username, password)
       @username = username
       @password = password
    end
    
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    
    def request(url,params)
        HTTP.post(url, :form => params).parse
    end
    
    def send(to,from,text,isFlash=false)
        url = sprintf @@path,"SendSMS"
        data = {
            :to=>to,
            :from=>from,
            :text=>text,
            :isFlash=>isFlash
        }
        result = nil
        t = Thread.new{ result = request(url,data.merge(get_data)) }
        t.join
        result
    end
    
    def send_by_base_number(text, to, bodyId)
        url = sprintf @@path,"BaseServiceNumber"
        data = {
            :text=>text,
            :to=>to,
            :bodyId=>bodyId
        }
        result = nil
        t = Thread.new{ result = request(url,data.merge(get_data)) }
        t.join
        result
    end
    
    def is_delivered(recId)
        url = sprintf @@path,"GetDeliveries2"
        data = {
            :recId=>recId,
        }
        result = nil
        t = Thread.new{ result = request(url,data.merge(get_data)) }
        t.join
        result
    end
    
    def get_messages(location, index, count, from="")
        url = sprintf @@path,"GetMessages"
        data = {
            :location=>location,
            :index=> index,
            :count=> count,
            :from=> from
        }
        result = nil
        t = Thread.new{ result = request(url,data.merge(get_data)) }
        t.join
        result
    end
    
    def get_credit
        url = sprintf @@path,"GetCredit"
        result = nil
        t = Thread.new{ result = request(url,get_data) }
        t.join
        result
    end
    
    def get_base_price
        url = sprintf @@path,"GetBasePrice"
        result = nil
        t = Thread.new{ result = request(url,get_data) }
        t.join
        result
    end
    
    def get_numbers
        url = sprintf @@path,"GetUserNumbers"
        result = nil
        t = Thread.new{ result = request(url,get_data) }
        t.join
        result
    end
 
 end
