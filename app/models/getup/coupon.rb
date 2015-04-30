module Getup
  class Coupon
    include HTTParty
    base_uri 'https://broker.getupcloud.com'
    # GETUP_SECRET_KEY_CODED = Base64.encode('username:secret_key')
    headers 'Authorization' => "Bearer #{ENV['GETUP_SECRET_KEY_CODED']}"

    class << self
      def new_coupon
        if response = create
          response['data'][0]['code'] if response['data'] && response['data'][0]
        end
      end

      def create(profile = '1gear', options = {})
        params = {
          body: {
            profile: profile
          },
          query: options
        }.reverse_merge(options).reverse_merge(default_params)
        post('/getup/partner/coupon/', params)
      end

      def list(options = {})
        params = { query: options }.reverse_merge(default_params)
        get('/getup/partner/coupon/', params)
      end

      def destroy(code, options = {})
        params = { query: options }.reverse_merge(default_params)
        delete("/getup/partner/coupon/#{code}/", params)
      end

      def get_info(options = {})
        params = { query: options }.reverse_merge(default_params)
        get('/getup/partner/', params)
      end
    end
  end
end
