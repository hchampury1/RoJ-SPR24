module WebinarsHelper
    def checkWebinars
        if params[:webinar_ids].nil? == false
            puts "\n\n\n\n\n test \n\n\n"
            @webinars.each do |webinar|
                if params[:webinar_ids].include?(webinar.id.to_s)
                    Webinar.update(webinar.id, csvEntry:"1")
                else
                    Webinar.update(webinar.id, csvEntry:"0")
                end

            end
        end
    end  
end
