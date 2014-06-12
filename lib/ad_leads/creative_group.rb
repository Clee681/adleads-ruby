module AdLeads
  class Client
    module CreativeGroup
      # params = {
      #   'name' => 'test creative group',
      #   'productName' =>  'test product',
      #   'privacyPolicyUrl' => 'http://privacy_url'
      # }

      def create_creative_group(options)
        post '/creativegroups', options
      end
    end
  end
end
