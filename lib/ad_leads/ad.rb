module AdLeads
  class Client
    module Ad
      # options = {
      #   'type' => 'Mobile',
      #   'name' =>  'test mobile ad',
      #   'headerText' => 'get your ad on this phone today',
      #   'bodyText' => 'this is mobile ad body copy'
      # }

      def create_ad(creative_group_id, options)
        post "/creativegroups/#{creative_group_id}/creatives", options
      end
    end
  end
end
