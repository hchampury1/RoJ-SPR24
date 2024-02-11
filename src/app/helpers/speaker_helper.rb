module SpeakerHelper

    def webinarList(speakerID)
        @speaker = Speaker.find_by(id:speakerID)
        return WebinarsSpeaker.select(:webinar_id).where(speaker_id: @speaker.id)
    end

end 
