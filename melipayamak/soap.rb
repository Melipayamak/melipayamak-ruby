require 'savon'

class Soap
  @@path = 'http://api.payamak-panel.com/post/%s.asmx?wsdl'
  def initialize(username, password)
    @username = username
    @password = password
    @sendUrl = format @@path, 'send'
    @receiveUrl = format @@path, 'receive'
    @voiceUrl = format @@path, 'Voice'
    @scheduleUrl = format @@path, 'Schedule'
  end

  def get_data
    {
      username: @username,
      password: @password
    }
  end

  def get_credit
    client = Savon.client(wsdl: @sendUrl)
    response = client.call(:get_credit, message: get_data)
    response.body
  end

  def is_delivered(recId)
    client = Savon.client(wsdl: @sendUrl)
    response = nil
    if recId.is_a?(Array)
      data = {
        recIds: recId
      }
      response = client.call(:get_deliveries, message: data.merge(get_data))
    else
      data = {
        recId: recId
      }
      response = client.call(:get_delivery, message: data.merge(get_data))
    end
    response.body
  end

  def send(to, from, text, isflash = false)
    client = Savon.client(wsdl: @sendUrl)
    nil
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash
    }
    response = if to.is_a?(Array)
                 client.call(:send_simple_sms, message: data.merge(get_data))
               else
                 client.call(:send_simple_sms2, message: data.merge(get_data))
               end
    response.body
  end

  def send2(to, from, text, isflash = false, udh = '')
    client = Savon.client(wsdl: @sendUrl)
    to = to.is_a?(Array) ? to : [to]
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash,
      udh: udh
    }
    response = client.call(:send_sms, message: data.merge(get_data))
    response.body
  end

  def send_with_domain(to, from, text, isflash, domainName)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash,
      domainName: domainName
    }
    response = client.call(:send_with_domain, message: data.merge(get_data))
    response.body
  end

  def send_by_base_number(text, to, bodyId)
    client = Savon.client(wsdl: @sendUrl)
    nil
    data = {
      text: text,
      to: to,
      bodyId: bodyId
    }
    response = if text.is_a?(Array)
                 client.call(:send_by_base_number, message: data.merge(get_data))
               else
                 client.call(:send_by_base_number2, message: data.merge(get_data))
               end
    response.body
  end

  def get_messages(location, index, count, from = '')
    client = Savon.client(wsdl: @sendUrl)
    data = {
      location: location,
      from: from,
      index: index,
      count: count
    }
    response = client.call(:get_messages, message: data.merge(get_data))
    response.body
  end

  def get_messages_str(location, index, count, from = '')
    client = Savon.client(wsdl: @receiveUrl)
    data = {
      location: location,
      from: from,
      index: index,
      count: count
    }
    response = client.call(:get_message_str, message: data.merge(get_data))
    response.body
  end

  def get_messages_by_date(location, index, count, dateFrom, dateTo, from = '')
    client = Savon.client(wsdl: @receiveUrl)
    data = {
      location: location,
      from: from,
      index: index,
      count: count,
      dateFrom: dateFrom,
      dateTo: dateTo
    }
    response = client.call(:get_messages_by_date, message: data.merge(get_data))
    response.body
  end

  def get_messages_receptions(msgId, fromRows)
    client = Savon.client(wsdl: @receiveUrl)
    data = {
      msgId: msgId,
      fromRows: fromRows
    }
    response = client.call(:get_messages_receptions, message: data.merge(get_data))
    response.body
  end

  def get_users_messages_by_date(location, index, count, from, dateFrom, dateTo)
    client = Savon.client(wsdl: @receiveUrl)
    data = {
      location: location,
      from: from,
      index: index,
      count: count,
      dateFrom: dateFrom,
      dateTo: dateTo
    }
    response = client.call(:get_users_messages_by_date, message: data.merge(get_data))
    response.body
  end

  def remove(msgIds)
    client = Savon.client(wsdl: @receiveUrl)
    data = {
      msgIds: msgIds
    }
    response = client.call(:remove_messages2, message: data.merge(get_data))
    response.body
  end

  def get_price(irancellCount, mtnCount, from, text)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      irancellCount: irancellCount,
      mtnCount: mtnCount,
      from: from,
      text: text
    }
    response = client.call(:get_sms_price, message: data.merge(get_data))
    response.body
  end

  def get_inbox_count(isRead = false)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      isRead: isRead
    }
    response = client.call(:get_inbox_count, message: data.merge(get_data))
    response.body
  end

  def send_with_speech(to, from, text, speech)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      to: to,
      from: from,
      smsBody: text,
      speechBody: speech
    }
    response = client.call(:send_sms_with_speech_text, message: data.merge(get_data))
    response.body
  end

  def send_with_speech_schdule_date(to, from, text, speech, scheduleDate)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      to: to,
      from: from,
      smsBody: text,
      speechBody: speech,
      scheduleDate: scheduleDate
    }
    response = client.call(:send_sms_with_speech_text_by_schdule_date, message: data.merge(get_data))
    response.body
  end

  def get_send_with_speech(recId)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      recId: recId
    }
    response = client.call(:get_send_sms_with_speech_text_status, message: data.merge(get_data))
    response.body
  end

  def get_multi_delivery(recId)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      recId: recId
    }
    response = client.call(:get_multi_delivery2, message: data.merge(get_data))
    response.body
  end

  def send_multiple_schedule(to, from, text, isflash, scheduleDateTime, period)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash,
      scheduleDateTime: scheduleDateTime,
      period: period
    }
    response = client.call(:add_multiple_schedule, message: data.merge(get_data))
    response.body
  end

  def send_schedule(to, from, text, isflash, scheduleDateTime, period)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash,
      scheduleDateTime: scheduleDateTime,
      period: period
    }
    response = client.call(:add_schedule, message: data.merge(get_data))
    response.body
  end

  def get_schedule_status(scheduleId)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      scheduleId: scheduleId
    }
    response = client.call(:get_schedule_status, message: data.merge(get_data))
    response.body
  end

  def remove_schedule(scheduleId)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      scheduleId: scheduleId
    }
    response = client.call(:remove_schedule, message: data.merge(get_data))
    response.body
  end

  def add_usance(to, from, text, isflash, scheduleStartDateTime, repeatAfterDays, scheduleEndDateTime)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      to: to,
      from: from,
      text: text,
      scheduleStartDateTime: scheduleStartDateTime,
      repeatAfterDays: repeatAfterDays,
      scheduleEndDateTime: scheduleEndDateTime,
      isflash: isflash
    }
    response = client.call(:add_usance, message: data.merge(get_data))
    response.body
  end


  # v2

  def send_by_base_number3(to, text)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      to: to,
      text: text
    }
    response = client.call(:send_by_base_number3, message: data.merge(get_data))
    response.body
  end

  def send_by_base_number4(to, bodyId, text, smsPrice)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      to: to,
      bodyId: bodyId,
      text: text,
      smsPrice: smsPrice
    }
    response = client.call(:send_by_base_number4, message: data.merge(get_data))
    response.body
  end

  def send_otp2(to, from, code)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      to: to,
      from: from,
      code: code
    }
    response = client.call(:send_otp2, message: data.merge(get_data))
    response.body
  end

  def send_sms2(to, from, text, isflash, udh)
    client = Savon.client(wsdl: @sendUrl)
    data = {
      to: to,
      from: from,
      text: text,
      udh: udh,
      isflash: isflash
    }
    response = client.call(:send_sms2, message: data.merge(get_data))
    response.body
  end

  def get_out_box_count()
    client = Savon.client(wsdl: @receiveUrl)
    response = client.call(:get_out_box_count, message: get_data)
    response.body
  end

  def add_new_usance(to, from, text, isflash, scheduleStartDateTime, countrepeat, scheduleEndDateTime, periodType)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      to: to,
      from: from,
      text: text,
      isflash: isflash,
      scheduleStartDateTime: scheduleStartDateTime,
      countrepeat: countrepeat,
      scheduleEndDateTime: scheduleEndDateTime,
      periodType: periodType
    }
    response = client.call(:add_new_usance, message: data.merge(get_data))
    response.body
  end

  def add_schedule_send_by_base_number2(to, text, bodyId, scheduleDate)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      to: to,
      text: text,
      bodyId: bodyId,
      scheduleDate: scheduleDate
    }
    response = client.call(:add_schedule_send_by_base_number2, message: data.merge(get_data))
    response.body
  end

  def get_schedule_details(scheduleId)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      scheduleId: scheduleId
    }
    response = client.call(:get_schedule_details, message: data.merge(get_data))
    response.body
  end

  def remove_schedule_list(scheduleIdList)
    client = Savon.client(wsdl: @scheduleUrl)
    data = {
      scheduleIdList: scheduleIdList
    }
    response = client.call(:remove_schedule_list, message: data.merge(get_data))
    response.body
  end

  def get_send_speech_text_status(recId)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      recId: recId
    }
    response = client.call(:get_send_speech_text_status, message: data.merge(get_data))
    response.body
  end

  def get_send_speech_text_statuses(recIds)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      recIds: recIds
    }
    response = client.call(:get_send_speech_text_statuses, message: data.merge(get_data))
    response.body
  end

  def send_bulk_speech_text(title, body, receivers, dateToSend, repeatCount)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      title: title,
      body: body,
      receivers: receivers,
      DateToSend: dateToSend,
      RepeatCount: repeatCount
    }
    response = client.call(:send_bulk_speech_text, message: data.merge(get_data))
    response.body
  end

  def send_bulk_voice_sms(title, voiceFileId, receivers, dateToSend, repeatCount)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      title: title,
      voiceFileId: voiceFileId,
      receivers: receivers,
      DateToSend: dateToSend,
      repeatCount: repeatCount
    }
    response = client.call(:send_bulk_voice_sms, message: data.merge(get_data))
    response.body
  end

  def send_speech_text(text, to)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      text: text,
      to: to
    }
    response = client.call(:send_speech_text, message: data.merge(get_data))
    response.body
  end

  def send_voice_otp(to, code)
    client = Savon.client(wsdl: @voiceUrl)
    data = {
      to: to, code: code
    }
    response = client.call(:send_voice_otp, message: data.merge(get_data))
    response.body
  end
  
end
