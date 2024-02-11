=begin
  Author: Andrew Michael
  Controller for viewing speaker information in secure manner.
=end

class SpeakerController < ApplicationController

  include SpeakerHelper
  skip_before_action :authenticate_user!, except: [:all]
  def new
  end
  def all
    @speakers = Speaker.all
  end

  def delete
    Speaker.destroy(params[:format])
    redirect_to speaker_all_path

  end

  def created
    Speaker.create!(name: params[:speakerName], description: params[:speakerInfo], link: params[:speakerLink] )
    redirect_to speaker_all_path


  end
  
  def show
  speaker_id = params["format"].to_i
  @speaker = Speaker.find_by(id: speaker_id)
  @webinars_id_array = WebinarsSpeaker.select(:webinar_id).where(speaker_id: @speaker.id)
  puts "Webinar ID[0] = #{@webinars_id_array[0].webinar_id.inspect}"
end

end
