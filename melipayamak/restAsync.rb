require 'http'

class RestAsync
  @@path = 'https://rest.payamak-panel.com/api/%s/'

  def initialize(username, password)
    @username = username
    @password = password
    @sendUrl = format @@path, 'SendSMS'
    @smartUrl = format @@path, 'SmartSMS'
    @sharedUrl = format @@path, 'ShareService'
    @voiceUrl = format @@path, 'Voice'
  end

  def get_data
    {
      username: @username,
      password: @password
    }
  end

  def request(url, params)
    HTTP.post(url, form: params).parse
  end

  def send(to, from, text, isFlash = false)
    data = {
      to: to,
      from: from,
      text: text,
      isFlash: isFlash
    }
    result = nil
    t = Thread.new { result = request(@sendUrl << 'SendSMS', data.merge(get_data)) }
    t.join
    result
  end

  def send_by_base_number(text, to, bodyId)
    data = {
      text: text,
      to: to,
      bodyId: bodyId
    }
    result = nil
    t = Thread.new { result = request(@sendUrl << 'BaseServiceNumber', data.merge(get_data)) }
    t.join
    result
  end

  def is_delivered(recId)
    data = {
      recId: recId
    }
    result = nil
    t = Thread.new { result = request(@sendUrl << 'GetDeliveries2', data.merge(get_data)) }
    t.join
    result
  end

  def get_messages(location, index, count, from = '')
    data = {
      location: location,
      index: index,
      count: count,
      from: from
    }
    result = nil
    t = Thread.new { result = request(@sendUrl << 'GetMessages', data.merge(get_data)) }
    t.join
    result
  end

  def get_credit
    result = nil
    t = Thread.new { result = request(@sendUrl << 'GetCredit', get_data) }
    t.join
    result
  end

  def get_base_price
    result = nil
    t = Thread.new { result = request(@sendUrl << 'GetBasePrice', get_data) }
    t.join
    result
  end

  def get_numbers
    result = nil
    t = Thread.new { result = request(@sendUrl << 'GetUserNumbers', get_data) }
    t.join
    result
  end


  # v2

  def send_otp(to, from, code)
    data = {
      to: to,
      from: from,
      code: code
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'SendOTP', data.merge(get_data)) }
    t.join
    result
  end

  def send_multiple_sms(from, to, text)
    data = {
      from: from,
      to: to,
      text: text
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'SendMultipleSMS', data.merge(get_data)) }
    t.join
    result
  end

  def send_schedule(text, to, from, scheduleDate, period)
    data = {
      text: text,
      to: to,
      from: from,
      scheduleDate: scheduleDate,
      period: period
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'SendSchedule', data.merge(get_data)) }
    t.join
    result
  end

  def get_schedule(scheduleId)
    data = {
      scheduleId: scheduleId
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'GetSchedule', data.merge(get_data)) }
    t.join
    result
  end

  def get_deliveries(recId)
    data = {
      recID: recId
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'GetDeliveries', data.merge(get_data)) }
    t.join
    result
  end

  def get_new_deliveries(recId)
    data = {
      recID: recId
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'GetNewDeliveries', data.merge(get_data)) }
    t.join
    result
  end

  def get_inbox_count(isRead)
    data = {
      isRead: isRead
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'GetInboxCount', data.merge(get_data)) }
    t.join
    result
  end

  def get_credit2()
    request(@sendUrl << 'GetCredit2', get_data)
  end

  def get_sms_price(irancellCount, mciCount, from, text)
    data = {
      irancellCount: irancellCount,
      mciCount: mciCount,
      from: from,
      text: text
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'GetSmsPrice', data.merge(get_data)) }
    t.join
    result
  end

  def base_service_number_schedule(text, to, bodyId, scheduleDate)
    data = {
      text: text,
      to: to,
      bodyId: bodyId,
      scheduleDate: scheduleDate
    }
    result = nil
    t = Thread.new { request(@sendUrl << 'BaseServiceNumberSchedule', data.merge(get_data)) }
    t.join
    result
  end

  def send_smart_sms(to, text, from, fromSupportOne, fromSupportTwo)
    data = {
      to: to,
      text: text,
      from: from,
      fromSupportOne: fromSupportOne,
      fromSupportTwo: fromSupportTwo
    }
    result = nil
    t = Thread.new { request(@smartUrl << 'Send', data.merge(get_data)) }
    t.join
    result
  end

  def send_multiple_smart_sms(to, text, from, fromSupportOne, fromSupportTwo)
    data = {
      to: to,
      text: text,
      from: from,
      fromSupportOne: fromSupportOne,
      fromSupportTwo: fromSupportTwo
    }
    result = nil
    t = Thread.new { request(@smartUrl << 'SendMultiple', data.merge(get_data)) }
    t.join
    result
  end

  def get_deliveries_smart_sms(ids)
    data = {
      Ids: ids
    }
    result = nil
    t = Thread.new { request(@smartUrl << 'GetDeliveries', data.merge(get_data)) }
    t.join
    result
  end

  def get_deliveries2_smart_sms(id)
    data = {
      Id: id
    }
    result = nil
    t = Thread.new { request(@smartUrl << 'GetDeliveries2', data.merge(get_data)) }
    t.join
    result
  end

  def add_body(title, body)
    data = {
      title: title,
      body: body
    }
    result = nil
    t = Thread.new { request(@sharedUrl << 'AddBody', data.merge(get_data)) }
    t.join
    result
  end

  def edit_body(title, body, bodyId)
    data = {
      title: title,
      body: body,
      bodyId: bodyId
    }
    result = nil
    t = Thread.new { request(@sharedUrl << 'EditBody', data.merge(get_data)) }
    t.join
    result
  end

  def delete_body(bodyId)
    data = {
      bodyId: bodyId
    }
    result = nil
    t = Thread.new { request(@sharedUrl << 'DeleteBody', data.merge(get_data)) }
    t.join
    result
  end

  def get_bodies(keyword, status)
    data = {
      keyword: keyword,
      status: status
    }
    result = nil
    t = Thread.new { request(@sharedUrl << 'GetBodies', data.merge(get_data)) }
    t.join
    result
  end

  def send_speech_text(text, to)
    data = {
      text: text,
      to: to
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendSpeechText', data.merge(get_data)) }
    t.join
    result
  end

  def send_voice_otp(to, code)
    data = {
      to: to,
      code: code
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendVoiceOtp', data.merge(get_data)) }
    t.join
    result
  end

  def send_sms_with_speech_text(smsBody, speechBody, from, to)
    data = {
      smsBody: smsBody,
      speechBody: speechBody,
      from: from,
      to: to
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendSMSWithSpeechText', data.merge(get_data)) }
    t.join
    result
  end

  def send_sms_with_speech_text_by_schdule_date(smsBody, speechBody, from, to, scheduleDate)
    data = {
      smsBody: smsBody,
      speechBody: speechBody,
      from: from,
      to: to,
      scheduleDate: scheduleDate
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendSMSWithSpeechTextBySchduleDate', data.merge(get_data)) }
    t.join
    result
  end

  def get_send_speech_text_status(recId)
    data = {
      recId: recId
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'GetMesGetSendSpeechTextStatussages', data.merge(get_data)) }
    t.join
    result
  end

  def get_send_speech_text_statuses(recIds)
    data = {
      recIds: recIds
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'GetSendSpeechTextStatuses', data.merge(get_data)) }
    t.join
    result
  end

  def get_send_sms_with_speech_text_status(recId)
    data = {
      recId: recId
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'GetSendSMSWithSpeechTextStatus', data.merge(get_data)) }
    t.join
    result
  end

  def send_bulk_speech_text(title, body, receivers, dateToSend, repeatCount)
    data = {
      title: title,
      body: body,
      receivers: receivers,
      DateToSend: dateToSend,
      RepeatCount: repeatCount
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendBulkSpeechText', data.merge(get_data)) }
    t.join
    result
  end

  def send_bulk_voice_sms(title, voiceFileId, receivers, dateToSend, repeatCount)
    data = {
      title: title,
      voiceFileId: voiceFileId,
      receivers: receivers,
      DateToSend: dateToSend,
      repeatCount: repeatCount
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'SendBulkVoiceSMS', data.merge(get_data)) }
    t.join
    result
  end

  def upload_voice_file(title, base64StringFile)
    data = {
      title: title,
      base64StringFile: base64StringFile
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'UploadVoiceFile', data.merge(get_data)) }
    t.join
    result
  end

  def upload_voice_file_byte(title, file)
    data = {
      title: title,
      file: file
    }
    result = nil
    t = Thread.new { request(@voiceUrl << 'UploadVoiceFileByte', data.merge(get_data)) }
    t.join
    result
  end

end
