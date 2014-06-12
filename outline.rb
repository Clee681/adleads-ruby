# In BTL - ad_leads_api_wrapper.rb

client = AdLeads::Client.new
client.build_campaign(options)
client.verify_campaign(campaign_id)
client.launch_campaign(campaign_id)

# In Ad Leads gem

module AdLeads
  class Client
    include AdLeads::Client::CreativeGroup
    include AdLeads::Client::Ad
    include AdLeads::Client::Campaign

    def post
    end

    def get
    end
  end
end

module AdLeads
  class Client
    module Campaign
      def build_campaign(options)
        create_creative(options['creative_info'])
        create_ad(@last_response['creative_id'], options['ad_info'])
        create_image(@last_response['creative_id'], @last_response['ad_id'], options['image_info'])
        create_campaign(options['campaign_info'])
      end

      def verify_campaign(campaign_id)
        get "/campaigns/#{campaign_id}"
      end

      def launch_campaign(etag)
        post "/campaigns/#{campaign_id}/launch", etag: etag
      end
    end
  end
end

module AdLeads
  class Client
    module Image
      def upload_image(file)
        count = 1
        set_etag
        post image_upload_path, upload_image_options(file)
      rescue EtagMisMatch
        count += 1
        set_etag
        upload_image(file) unless count > 3
      end

      def upload_image_options(file)
        opts = {
          file: Faraday::UploadIO.new(file, 'image/jpeg'),
          etag: etag
        }
      end
    end
  end
end


module AdLeads
  class Client
    module Creative
      def create_creative(options)
        post "bladkjfad", options
      end
    end
  end
end

