module AdLeads
  class CreativeGroup < AdLeads::Base

    # params = {
    #   'name' => 'test creative group',
    #   'productName' =>  'test product',
    #   'privacyPolicyUrl' => 'http://privacy_url'
    # }

    def root_path
      '/creativegroups'
    end
  end
end
