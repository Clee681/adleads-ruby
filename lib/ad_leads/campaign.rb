module AdLeads
  class Client
    module Campaign
      def create_campaign(options)
        post '/campaigns', options
      end

      def update_campaign(id, options)
        post campaign_path(id), options
      end

      def verify_campaign(id)
        get verify_campaign_path(id)
      end

      def launch_campaign(id)
        remaining_tries ||= 3
        post launch_campaign_path(id), etag: campaign_etag(id).headers['Etag']
      rescue AdLeads::EtagMismatchError
        remaining_tries -= 1
        retry unless remaining_tries.zero?
      end

      private

      def campaign_path(id)
        "/campaigns/#{id}"
      end
      alias :campaign_etag_path :campaign_path

      def launch_campaign_path(id)
        campaign_path(id) + '/launch'
      end

      def verify_campaign_path(id)
        campaign_path(id) + '/plan'
      end

      def campaign_etag(id)
        get campaign_etag_path(id)
      end
    end
  end
end
