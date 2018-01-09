require 'savon'

class Contacts
    def initialize(username, password)
        @username = username
        @password = password
        @client = Savon.client(wsdl: "http://api.payamak-panel.com/post/contacts.asmx?wsdl")
    end
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    def execute(method,data)
        response = @client.call(method, message:data.merge(get_data))
        response.body
    end
    def add_group(groupName, descriptions, showToChilds)
        execute(:add_group,{
            :groupName => groupName,
            :Descriptions => descriptions,
            :showToChilds => showToChilds
        })
    end
    def add(options)
        execute(:add_contact,options)
    end
    def check_mobile_exist(mobileNumber)
        execute(:check_mobile_exist_in_contact,{
            :mobileNumber => mobileNumber
        })
    end
    def get(groupId, keyword, from, count)
        execute(:get_contacts,{
            :groupId => groupId,
            :keyword => keyword,
            :from => from,
            :count => count,
        })
    end
    def get_groups
        execute(:get_groups,{})
    end
    def change(options)
        execute(:change_contact,options)
    end
    def remove(mobileNumber)
        execute(:remove_contact,{
            :mobileNumber => mobileNumber
        })
    end
    def get_events(contactId)
        execute(:get_contact_events,{
            :contactId => contactId
        })
    end
end