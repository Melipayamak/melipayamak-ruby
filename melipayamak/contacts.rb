require 'savon'

class Contacts
  def initialize(username, password)
    @username = username
    @password = password
    @client = Savon.client(wsdl: 'http://api.payamak-panel.com/post/contacts.asmx?wsdl')
  end

  def get_data
    {
      username: @username,
      password: @password
    }
  end

  def execute(method, data)
    response = @client.call(method, message: data.merge(get_data))
    response.body
  end

  def add_group(groupName, descriptions, showToChilds)
    execute(:add_group, {
              groupName: groupName,
              Descriptions: descriptions,
              showToChilds: showToChilds
            })
  end

  def add(options)
    execute(:add_contact, options)
  end

  def check_mobile_exist(mobileNumber)
    execute(:check_mobile_exist_in_contact, {
              mobileNumber: mobileNumber
            })
  end

  def get(groupId, keyword, from, count)
    execute(:get_contacts, {
              groupId: groupId,
              keyword: keyword,
              from: from,
              count: count
            })
  end

  def get_groups
    execute(:get_groups, {})
  end

  def change(options)
    execute(:change_contact, options)
  end

  def remove(mobileNumber)
    execute(:remove_contact, {
              mobileNumber: mobileNumber
            })
  end

  def get_events(contactId)
    execute(:get_contact_events, {
              contactId: contactId
            })
  end

  # v2

  def add_contact2(groupIds, firstname, lastname, gender, corporation, mobilenumber)
    execute(:add_contact2, {
              contactId: contactId
            })
  end

  def add_contact_events(contactId, eventName, eventType, eventDate)
    execute(:add_contact_events, {
              contactId: contactId,
              eventName: eventName,
              eventType: eventType,
              eventDate: eventDate
            })
  end
  
  def change_contact2(options)
    execute(:change_contact2, options)
  end

  def change_group(groupId, groupName, descriptions, showToChilds, groupStatus)
    execute(:change_group, {
              groupId: groupId,
              groupName: groupName,
              Descriptions: descriptions,
              showToChilds: showToChilds,
              groupStatus: groupStatus
            })
  end

  def remove_contact2(contactId, groupId)
    execute(:remove_contact2, {
              contactId: contactId,
              groupId: groupId
            })
  end

  def remove_group(groupId)
    execute(:remove_group, {
              groupId: groupId
            })
  end
end
