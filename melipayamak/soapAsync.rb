require 'savon'

class SoapAsync
    @@path = "http://api.payamak-panel.com/post/%s.asmx?wsdl"
    def initialize(username, password)
        @username = username
        @password = password
        @sendUrl = sprintf @@path,"send"
        @receiveUrl = sprintf @@path,"receive"
        @voiceUrl = sprintf @@path,"Voice"
        @scheduleUrl = sprintf @@path,"Schedule"
    end
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    def get_credit
        client = Savon.client(wsdl: @sendUrl)
        response = nil
        t = Thread.new{response = client.call(:get_credit, message:get_data)}
        t.join
        response.body
    end
    def is_delivered recId
        client = Savon.client(wsdl: @sendUrl)
        response = nil
        if recId.kind_of?(Array)
            data = {
                :recIds => recId
            }
            t = Thread.new{response = client.call(:get_deliveries, message:data.merge(get_data))}
            t.join
        else
            data = {
                :recId => recId
            }
            t = Thread.new{response = client.call(:get_delivery, message:data.merge(get_data))}
            t.join
        end

        response.body
    end
    def send(to, from, text, isflash=false)
        client = Savon.client(wsdl: @sendUrl)
        response = nil
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash
        }
        if to.kind_of?(Array)
            t = Thread.new{response = client.call(:send_simple_sms, message:data.merge(get_data))}
            t.join
        else
            t = Thread.new{response = client.call(:send_simple_sms2, message:data.merge(get_data))}
            t.join
        end
        
        response.body
    end
    def send2(to, from, text, isflash= false,udh="")
        client = Savon.client(wsdl: @sendUrl)
        to =  to.kind_of?(Array) ? to : [to]
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash,
            :udh => udh
        }
        response = nil
        t = Thread.new{response = client.call(:send_sms, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_with_domain(to, from, text, isflash, domainName)
        client = Savon.client(wsdl: @sendUrl)
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash,
            :domainName => domainName
        }
        response = nil
        t = Thread.new{response = client.call(:send_with_domain, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_by_base_number(text, to, bodyId)
        client = Savon.client(wsdl: @sendUrl)
        response = nil
        data = {
            :text => text,
            :to => to,
            :bodyId => bodyId
        }
        if text.kind_of?(Array)
            t = Thread.new{response = client.call(:send_by_base_number, message:data.merge(get_data))}
            t.join
        else
            t = Thread.new{response = client.call(:send_by_base_number2, message:data.merge(get_data))}
            t.join
        end
        response.body
    end
    def get_messages(location, index, count, from="")
        client = Savon.client(wsdl: @sendUrl)
        data = {
            :location => location,
            :from => from,
            :index => index,
            :count => count
        }
        response = nil
        t = Thread.new{response = client.call(:get_messages, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_messages_str(location, index, count, from="")
        client = Savon.client(wsdl: @receiveUrl)
        data = {
            :location => location,
            :from => from,
            :index => index,
            :count => count
        }
        response = nil
        t = Thread.new{response = client.call(:get_message_str, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_messages_by_date( location, index, count, dateFrom, dateTo, from="")
        client = Savon.client(wsdl: @receiveUrl)
        data = {
            :location => location,
            :from => from,
            :index => index,
            :count => count,
            :dateFrom => dateFrom,
            :dateTo => dateTo
        }
        response = nil
        t = Thread.new{response = client.call(:get_messages_by_date, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_messages_receptions(msgId, fromRows)
        client = Savon.client(wsdl: @receiveUrl)
        data = {
            :msgId => msgId,
            :fromRows => fromRows
        }
        response = nil
        t = Thread.new{response = client.call(:get_messages_receptions, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_users_messages_by_date(location, index, count, from,dateFrom, dateTo)
        client = Savon.client(wsdl: @receiveUrl)
        data = {
            :location => location,
            :from => from,
            :index => index,
            :count => count,
            :dateFrom => dateFrom,
            :dateTo => dateTo
        }
        response = nil
        t = Thread.new{response = client.call(:get_users_messages_by_date, message:data.merge(get_data))}
        t.join
        response.body
    end
    def remove(msgIds)
        client = Savon.client(wsdl: @receiveUrl)
        data = {
            :msgIds => msgIds
        }
        response = nil
        t = Thread.new{response = client.call(:remove_messages2, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_price(irancellCount, mtnCount,  from, text)
        client = Savon.client(wsdl: @sendUrl)
        data = {
            :irancellCount => irancellCount,
            :mtnCount => mtnCount,
            :from => from,
            :text => text
        }
        response = nil
        t = Thread.new{response = client.call(:get_sms_price, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_inbox_count(isRead=false)
        client = Savon.client(wsdl: @sendUrl)
        data = {
            :isRead => isRead
        }
        response = nil
        t = Thread.new{response = client.call(:get_inbox_count, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_with_speech(to, from, text, speech)
        client = Savon.client(wsdl: @voiceUrl)
        data = {
            :to => to,
            :from => from,
            :smsBody => text,
            :speechBody => speech
        }
        response = nil
        t = Thread.new{response = client.call(:send_sms_with_speech_text, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_with_speech_schdule_date(to, from, text, speech, scheduleDate)
        client = Savon.client(wsdl: @voiceUrl)
        data = {
            :to => to,
            :from => from,
            :smsBody => text,
            :speechBody => speech,
            :scheduleDate => scheduleDate
        }
        response = nil
        t = Thread.new{response = client.call(:send_sms_with_speech_text_by_schdule_date, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_send_with_speech(recId)
        client = Savon.client(wsdl: @voiceUrl)
        data = {
            :recId => recId
        }
        response = nil
        t = Thread.new{response = client.call(:get_send_sms_with_speech_text_status, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_multi_delivery(recId)
        client = Savon.client(wsdl: @sendUrl)
        data = {
            :recId => recId
        }
        response = nil
        t = Thread.new{response = client.call(:get_multi_delivery2, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_multiple_schedule(to, from, text, isflash, scheduleDateTime, period)
        client = Savon.client(wsdl: @scheduleUrl)
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash,
            :scheduleDateTime => scheduleDateTime,
            :period => period
        }
        response = nil
        t = Thread.new{response = client.call(:add_multiple_schedule, message:data.merge(get_data))}
        t.join
        response.body
    end
    def send_schedule(to, from, text, isflash, scheduleDateTime, period)
        client = Savon.client(wsdl: @scheduleUrl)
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash,
            :scheduleDateTime => scheduleDateTime,
            :period => period
        }
        response = nil
        t = Thread.new{response = client.call(:add_schedule, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get_schedule_status(scheduleId)
        client = Savon.client(wsdl: @scheduleUrl)
        data = {
            :scheduleId => scheduleId
        }
        response = nil
        t = Thread.new{response = client.call(:get_schedule_status, message:data.merge(get_data))}
        t.join
        response.body
    end
    def remove_schedule(scheduleId)
        client = Savon.client(wsdl: @scheduleUrl)
        data = {
            :scheduleId => scheduleId
        }
        response = nil
        t = Thread.new{response = client.call(:remove_schedule, message:data.merge(get_data))}
        t.join
        response.body
    end
    def add_usance(to, from, text, isflash, scheduleStartDateTime, repeatAfterDays, scheduleEndDateTime)
        client = Savon.client(wsdl: @scheduleUrl)
        data = {
            :to => to,
            :from => from,
            :text => text,
            :scheduleStartDateTime => scheduleStartDateTime,
            :repeatAfterDays => repeatAfterDays,
            :scheduleEndDateTime => scheduleEndDateTime,
            :isflash => isflash
        }
        response = nil
        t = Thread.new{response = client.call(:add_usance, message:data.merge(get_data))}
        t.join
        response.body
    end
end
