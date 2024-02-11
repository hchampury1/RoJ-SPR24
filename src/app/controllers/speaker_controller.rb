=begin
  Author: Andrew Michael
  Controller for viewing speaker information in secure manner.
=end

class SpeakerController < ApplicationController
  skip_before_action :authenticate_user!
  def new

  end
  def created
    Speaker.create!(name: params[:speakerInfo])
    redirect_to new_webinar_path
  end
  
  def show
    speaker_id = params["format"].to_i
    @speaker = Speaker.find_by(id: speaker_id)
    @webinars_id_array = WebinarsSpeaker.select(:webinar_id).where(speaker_id: @speaker.id)
    puts "Webinar ID[0] = #{@webinars_id_array[0].webinar_id.inspect}\n\n\n\n"
  end
end
