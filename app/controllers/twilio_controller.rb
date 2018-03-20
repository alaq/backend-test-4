require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST ivr/welcome
  # this is the entry point of the IVR
  def ivr_welcome
    response = Twilio::TwiML::VoiceResponse.new do |r|
      gather = Twilio::TwiML::Gather.new(num_digits: '1', action: menu_path)
      gather.say('Hello, to talk to someone press 1, to leave a voicemail press 2.', voice: 'alice')
      r.append(gather)
    end
    render xml: response.to_s
  end

  # GET ivr/selection
  # menu_path
  def menu_selection
    # First if there's a recording already we end the conversation and save to the database
    recording_duration = params[:RecordingDuration].to_i
    if (recording_duration > 0)
     response = Twilio::TwiML::VoiceResponse.new do |r|
       r.say("Voicemail recorded, have a nice day!")
       r.hangup()
      end
      render xml: response.to_s

      # Here we save the new details to the database
      callid = params[:CallSid]
      currentCall = Call.find_by(callid: callid)

      puts params[:RecordingUrl]
      status = params[:CallStatus]
      recording_duration = params[:RecordingDuration].to_i
      recording_url = params[:RecordingUrl]
      call_duration = params[:CallDuration].to_i
      currentCall.update_attributes(status: "completed", recording_duration: recording_duration, recording_url: recording_url, call_duration: call_duration, selection: "voicemail")

    else # main user menu, i.e. there is no preexisting recording
      user_selection = params[:Digits]

     # Extract information from the POST request
     caller = params[:Caller]
     status = params[:CallStatus]
     callid = params[:CallSid]
     newCall = Call.create(callid: callid, caller: caller, status: status)
     newCall.save

      # Deal with the user's choice
      case user_selection
      when "1"
        response = Twilio::TwiML::VoiceResponse.new
        response.dial do |dial|
          dial.number('646-410-3409')
        end
        render xml: response.to_s
        callid = params[:CallSid]
        currentCall = Call.find_by(callid: callid)

        status = params[:CallStatus]
        call_duration = params[:CallDuration].to_i
        currentCall.update_attributes(status: "completed", call_duration: call_duration, selection: "transfer")
      when "2"
        response = Twilio::TwiML::VoiceResponse.new do |r|
          r.say('Your message will be recorded after the beep. When you are done, press pound.')
          r.record(finish_on_key: "#")
          r.say('Sorry, we were enable to record your voicemail.')
        end
        render xml: response.to_s
      end
    end
  end

end

