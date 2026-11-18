require 'http'

class Rest
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
    request(@sendUrl << 'SendSMS', data.merge(get_data))
  end

  def send_by_base_number(text, to, bodyId)
    data = {
      text: text,
      to: to,
      bodyId: bodyId
    }
    request(@sendUrl << 'BaseServiceNumber', data.merge(get_data))
  end

  def is_delivered(recId)
    data = {
      recId: recId
    }
    request(@sendUrl << 'GetDeliveries2', data.merge(get_data))
  end

  def get_messages(location, index, count, from = '')
    data = {
      location: location,
      index: index,
      count: count,
      from: from
    }
    request(@sendUrl << 'GetMessages', data.merge(get_data))
  end

  def get_credit
    request(@sendUrl << 'GetCredit', get_data)
  end

  def get_base_price
    request(@sendUrl << 'GetBasePrice', get_data)
  end

  def get_numbers
    request(@sendUrl << 'GetUserNumbers', get_data)
  end


  # v2

  def send_otp(to, from, code)
    data = {
      to: to,
      from: from,
      code: code
    }
    request(@sendUrl << 'SendOTP', data.merge(get_data))
  end

  def send_multiple_sms(from, to, text)
    data = {
      from: from,
      to: to,
      text: text
    }
    request(@sendUrl << 'SendMultipleSMS', data.merge(get_data))
  end

  def send_schedule(text, to, from, scheduleDate, period)
    data = {
      text: text,
      to: to,
      from: from,
      scheduleDate: scheduleDate,
      period: period
    }
    request(@sendUrl << 'SendSchedule', data.merge(get_data))
  end

  def get_schedule(scheduleId)
    data = {
      scheduleId: scheduleId
    }
    request(@sendUrl << 'GetSchedule', data.merge(get_data))
  end

  def get_deliveries(recId)
    data = {
      recID: recId
    }
    request(@sendUrl << 'GetDeliveries', data.merge(get_data))
  end

  def get_new_deliveries(recId)
    data = {
      recID: recId
    }
    request(@sendUrl << 'GetNewDeliveries', data.merge(get_data))
  end

  def get_inbox_count(isRead)
    data = {
      isRead: isRead
    }
    request(@sendUrl << 'GetInboxCount', data.merge(get_data))
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
    request(@sendUrl << 'GetSmsPrice', data.merge(get_data))
  end

  def base_service_number_schedule(text, to, bodyId, scheduleDate)
    data = {
      text: text,
      to: to,
      bodyId: bodyId,
      scheduleDate: scheduleDate
    }
    request(@sendUrl << 'BaseServiceNumberSchedule', data.merge(get_data))
  end

  def send_smart_sms(to, text, from, fromSupportOne, fromSupportTwo)
    data = {
      to: to,
      text: text,
      from: from,
      fromSupportOne: fromSupportOne,
      fromSupportTwo: fromSupportTwo
    }
    request(@smartUrl << 'Send', data.merge(get_data))
  end

  def send_multiple_smart_sms(to, text, from, fromSupportOne, fromSupportTwo)
    data = {
      to: to,
      text: text,
      from: from,
      fromSupportOne: fromSupportOne,
      fromSupportTwo: fromSupportTwo
    }
    request(@smartUrl << 'SendMultiple', data.merge(get_data))
  end

  def get_deliveries_smart_sms(ids)
    data = {
      Ids: ids
    }
    request(@smartUrl << 'GetDeliveries', data.merge(get_data))
  end

  def get_deliveries2_smart_sms(id)
    data = {
      Id: id
    }
    request(@smartUrl << 'GetDeliveries2', data.merge(get_data))
  end

  def add_body(title, body)
    data = {
      title: title,
      body: body
    }
    request(@sharedUrl << 'AddBody', data.merge(get_data))
  end

  def edit_body(title, body, bodyId)
    data = {
      title: title,
      body: body,
      bodyId: bodyId
    }
    request(@sharedUrl << 'EditBody', data.merge(get_data))
  end

  def delete_body(bodyId)
    data = {
      bodyId: bodyId
    }
    request(@sharedUrl << 'DeleteBody', data.merge(get_data))
  end

  def get_bodies(keyword, status)
    data = {
      keyword: keyword,
      status: status
    }
    request(@sharedUrl << 'GetBodies', data.merge(get_data))
  end

  def send_speech_text(text, to)
    data = {
      text: text,
      to: to
    }
    request(@voiceUrl << 'SendSpeechText', data.merge(get_data))
  end

  def send_voice_otp(to, code)
    data = {
      to: to,
      code: code
    }
    request(@voiceUrl << 'SendVoiceOtp', data.merge(get_data))
  end

  def send_sms_with_speech_text(smsBody, speechBody, from, to)
    data = {
      smsBody: smsBody,
      speechBody: speechBody,
      from: from,
      to: to
    }
    request(@voiceUrl << 'SendSMSWithSpeechText', data.merge(get_data))
  end

  def send_sms_with_speech_text_by_schdule_date(smsBody, speechBody, from, to, scheduleDate)
    data = {
      smsBody: smsBody,
      speechBody: speechBody,
      from: from,
      to: to,
      scheduleDate: scheduleDate
    }
    request(@voiceUrl << 'SendSMSWithSpeechTextBySchduleDate', data.merge(get_data))
  end

  def get_send_speech_text_status(recId)
    data = {
      recId: recId
    }
    request(@voiceUrl << 'GetMesGetSendSpeechTextStatussages', data.merge(get_data))
  end

  def get_send_speech_text_statuses(recIds)
    data = {
      recIds: recIds
    }
    request(@voiceUrl << 'GetSendSpeechTextStatuses', data.merge(get_data))
  end

  def get_send_sms_with_speech_text_status(recId)
    data = {
      recId: recId
    }
    request(@voiceUrl << 'GetSendSMSWithSpeechTextStatus', data.merge(get_data))
  end

  def send_bulk_speech_text(title, body, receivers, dateToSend, repeatCount)
    data = {
      title: title,
      body: body,
      receivers: receivers,
      DateToSend: dateToSend,
      RepeatCount: repeatCount
    }
    request(@voiceUrl << 'SendBulkSpeechText', data.merge(get_data))
  end

  def send_bulk_voice_sms(title, voiceFileId, receivers, dateToSend, repeatCount)
    data = {
      title: title,
      voiceFileId: voiceFileId,
      receivers: receivers,
      DateToSend: dateToSend,
      repeatCount: repeatCount
    }
    request(@voiceUrl << 'SendBulkVoiceSMS', data.merge(get_data))
  end

  def upload_voice_file(title, base64StringFile)
    data = {
      title: title,
      base64StringFile: base64StringFile
    }
    request(@voiceUrl << 'UploadVoiceFile', data.merge(get_data))
  end

  def upload_voice_file_byte(title, file)
    data = {
      title: title,
      file: file
    }
    request(@voiceUrl << 'UploadVoiceFileByte', data.merge(get_data))
  end


end
